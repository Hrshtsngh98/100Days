//
//  TutorialView2.swift
//  Bucket List
//
//  Created by Harshit Singh on 4/9/25.
//

import MapKit
import SwiftUI

struct LocationTutorial: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct TutorialView2: View {
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    let locations = [
        LocationTutorial(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        LocationTutorial(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
//        Map()
//            .mapStyle(.imagery)
//            .mapStyle(.hybrid)
        
//        Map(interactionModes: [.rotate, .zoom])
//            .mapStyle(.hybrid(elevation: .realistic))
        
        // No interaction allowed
//        Map(interactionModes: [])
//            .mapStyle(.hybrid(elevation: .realistic))
        
//        Map(initialPosition: position)
        
        VStack {
//            Map(position: $position)
//                .mapStyle(.hybrid)
//                .onMapCameraChange { context in
//                    // on release
//                    print("Camera changed: \(context)")
//                }
//                .onMapCameraChange(frequency: .continuous) { context in
//                    //continuous
//                    print(context.region)
//                }
            
//            HStack(spacing: 50) {
//                Button("Paris") {
//                    position = MapCameraPosition.region(
//                        MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
//                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                        )
//                    )
//                }
//
//                Button("Tokyo") {
//                    position = MapCameraPosition.region(
//                        MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
//                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                        )
//                    )
//                }
//            }
            
            MapReader { proxy in
                Map {
                    ForEach(locations) { location in
                        // Default view
                        // Marker(location.name, coordinate: location.coordinate)
                        
                        //Custom view
                        Annotation(location.name, coordinate: location.coordinate) {
                            Text(location.name)
                                .font(.headline)
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.capsule)
                        }
                        .annotationTitles(.hidden)
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                }
            }
        }

    }
}

#Preview {
    TutorialView2()
}
