//
//  ContentView.swift
//  HotProspects
//
//  Created by Harshit Singh on 4/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = Set<String>()
    @State private var sortOrder: ProspectsView.SortType = .ascendingName

    var body: some View {
        TabView {
            ProspectsView(filter: .none, sortType: $sortOrder)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}
