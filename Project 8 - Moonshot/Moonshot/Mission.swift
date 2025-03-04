//
//  Mission.swift
//  Moonshot
//
//  Created by Harshit Singh on 2/28/25.
//

import Foundation

struct Mission: Codable, Identifiable {
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
}
