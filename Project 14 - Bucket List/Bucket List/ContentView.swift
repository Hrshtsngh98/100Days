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
    
    @State private var viewModel: ViewModel = .init()

    var body: some View {
        VStack {
            if viewModel.isUnlocked {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: location.updated ? "star.circle.fill" : "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in
                                        print("Selected a place")
                                        viewModel.selectPlace(location)
                                    })
                            }
                        }
                    }
                    .mapStyle(.hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) { newLocation in
                            viewModel.updateLocation(newLocation)
                        } onDelete: { location in
                            viewModel.deleteLocation(location: location)
                        }
                    }
                }
            } else {
                Button {
                    viewModel.authenticate()
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: "faceid")
                            .font(.largeTitle)
                        Text("Unlock")
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
