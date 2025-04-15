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
    @State private var showMapOptions: Bool = false
    @State private var mapStyle: MapStyle = .hybrid

    var body: some View {
        VStack {
            if viewModel.isUnlocked {
                ZStack(alignment: .topTrailing) {
                    mapView
                    Button {
                        showMapOptions = true
                    } label: {
                        Image(systemName: "map.circle")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .padding(.trailing, 8)
                }
                .confirmationDialog("Map Mode", isPresented: $showMapOptions) {
                    Button("Standard") {
                        mapStyle = .standard
                    }
                    Button("Hybrid") {
                        mapStyle = .hybrid
                    }
                    Button("Imagery") {
                        mapStyle = .imagery
                    }
                    Button("Image - flat") {
                        mapStyle = .imagery(elevation: .flat)
                    }
                    Button("Image - realistic") {
                        mapStyle = .imagery(elevation: .realistic)
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
                .alert("Authentication failed!", isPresented: $viewModel.authenticationError) {
                    Button("OK") { }
                    Button("Retry") {
                        viewModel.authenticate()
                    }
                }

            }
        }
    }
    
    private var mapView: some View {
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
            .mapStyle(mapStyle)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    viewModel.addLocation(coordinate)
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(vm: .init(location: place)) { newLocation in
                    viewModel.updateLocation(newLocation)
                } onDelete: { location in
                    viewModel.deleteLocation(location: location)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
