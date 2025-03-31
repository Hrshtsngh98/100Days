//
//  Challenge5App.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/30/25.
//

import SwiftData
import SwiftUI

@main
struct Challenge5App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
                .modelContainer(for: Friend.self)
        }
    }
}
