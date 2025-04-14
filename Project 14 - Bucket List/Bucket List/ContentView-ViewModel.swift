//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Harshit Singh on 4/14/25.
//

import CoreLocation
import SwiftUI
import MapKit
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked: Bool = false
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func selectPlace(_ place: Location) {
            selectedPlace = place
        }
        
        func addLocation(_ coordinate: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
            locations.append(newLocation)
        }
        
        func updateLocation(_ location: Location) {
            guard let place = selectedPlace else { return }
            
            if let indexPath = locations.firstIndex(of: place) {
                print("Place updated")
                locations[indexPath] = location
            }
            save()
        }
        
        func deleteLocation(location: Location) {
            if let index = locations.firstIndex(of: location) {
                print("Place removed")
                locations.remove(at: index)
                save()
                selectedPlace = nil
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                    } else {
                        print("Biometric failed")
                    }
                }
            } else {
                // no biometrics
                print("Can't do biometric authentication")
            }
        }
    }
}
