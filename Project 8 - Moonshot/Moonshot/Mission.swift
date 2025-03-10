//
//  Mission.swift
//  Moonshot
//
//  Created by Harshit Singh on 2/28/25.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable, Equatable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var displayLaunchDate: String? {
        launchDate?.formatted(date: .abbreviated, time: .omitted)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Mission, rhs: Mission) -> Bool {
        lhs.id == rhs.id
    }
}
