//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/18/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            TutorialView3()
        }
        .modelContainer(for: Student.self)
    }
}
