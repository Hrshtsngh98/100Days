//
//  MissionView.swift
//  Moonshot
//
//  Created by Harshit Singh on 3/3/25.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    @Binding var path: NavigationPath
    let mission: Mission
    let crew: [CrewMember]
    
    init(path: Binding<NavigationPath>, mission: Mission, astronauts: [String: Astronaut]) {
        self._path = path
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                    .accessibilityHidden(true)
                
                if mission.displayLaunchDate != "unknown" {
                    Text(mission.displayLaunchDate)
                        .font(.title.bold())
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .accessibilityLabel("Launch Date: \(mission.displayLaunchDate)")
                }
                
                missionHighlightView
                    .padding(.horizontal)
            }
            
            astronautListView
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .toolbarRole(.editor)
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
    
    private var missionHighlightView: some View {
        VStack(alignment: .leading) {
            divider
            
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(mission.description)
            
            divider
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
        }
    }
    
    private var astronautListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    HStack {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(.capsule)
                            .overlay(
                                Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(crewMember.role): \(crewMember.astronaut.name)")
                    .accessibilityAddTraits(.isButton)
                    .padding(.horizontal)
                    .onTapGesture {
                        path.append(crewMember.astronaut)
                    }
                }
            }
        }
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionView(path: .constant(.init()), mission: mission[2], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
