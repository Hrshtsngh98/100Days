//
//  ContentView.swift
//  Moonshot
//
//  Created by Harshit Singh on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State var path: NavigationPath = .init()
    @State var showingGrid = true
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                if showingGrid {
                    vGridMissions
                } else {
                    vStackMissions
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle("Grid", isOn: $showingGrid)
                        .toggleStyle(.switch)
                        .tint(.red)
                }
            }
            .navigationDestination(for: Mission.self, destination: { mission in
                MissionView(path: $path, mission: mission, astronauts: astronauts)
            })
            .navigationDestination(for: Astronaut.self, destination: { astronaut in
                AstronautView(astronaut: astronaut)
            })
        }
        .preferredColorScheme(.dark)
    }
    
    private var vGridMissions: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text(mission.displayLaunchDate ?? "N/A")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .onTapGesture {
                    path.append(mission)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                }
            }
        }
        .padding()
    }
    
    private var vStackMissions: some View {
        VStack(spacing: 16) {
            ForEach(missions) { mission in
                HStack(spacing: 0) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                        .padding(.horizontal, 16)
                        .padding(.vertical)
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text(mission.displayLaunchDate ?? "N/A")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.lightBackground)
                }
                .onTapGesture {
                    path.append(mission)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
