//
//  ContentView.swift
//  Bucket List
//
//  Created by Harshit Singh on 4/7/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    @State private var showSheet: Bool = false

    var body: some View {
        VStack {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: location.updated ? "star.circle.fill" : "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in
                                    print("Selected a place")
                                    selectedPlace = location
                                })
                        }
                    }
                }
                .mapStyle(.hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                    }
                }
                .sheet(item: $selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        if let indexPath = locations.firstIndex(of: place) {
                            print("Place updated")
                            locations[indexPath] = newLocation
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
