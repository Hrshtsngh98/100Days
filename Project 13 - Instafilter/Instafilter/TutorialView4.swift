//
//  TutorialView4.swift
//  Instafilter
//
//  Created by Harshit Singh on 4/3/25.
//

import SwiftUI

struct TutorialView4: View {
    var body: some View {
        
        ContentUnavailableView("No snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet."))
        
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create Snippet") {
                // create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    TutorialView4()
}
