//
//  TutorialView2.swift
//  HotProspects
//
//  Created by Harshit Singh on 4/24/25.
//

import SwiftUI

struct TutorialView2: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("Tab 1", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Tab 2", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}

#Preview {
    TutorialView2()
}
