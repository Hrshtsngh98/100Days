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
            ContentView()
        }
//        .modelContainer(for: Student.self)
        .modelContainer(for: Book.self)

    }
}
