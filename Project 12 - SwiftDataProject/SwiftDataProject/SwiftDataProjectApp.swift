//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Harshit Singh on 3/28/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)

    }
}
