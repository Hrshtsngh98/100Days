//
//  TutorialView1.swift
//  SnowSeeker
//
//  Created by Harshit Singh on 5/21/25.
//

import SwiftUI

struct TutorialView1: View {
    var body: some View {
        NavigationSplitView(preferredCompactColumn: .constant(.detail), sidebar: {
            Text("Side bar")
        }) {
            NavigationLink("Primary") {
                Text("New view")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .navigationSplitViewStyle(.balanced)

    }
}

#Preview {
    TutorialView1()
}
