//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Harshit Singh on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var favorites = Favorites()
    @State private var showSortSheet = false
    
    @State var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSortSheet = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .confirmationDialog("Sortby:", isPresented: $showSortSheet) {
                ForEach(SortOrder.allCases, id: \.self) { option in
                    Button(option.name) {
                        sortBy(order: option)
                    }
                }
            } message: {
                Text("Sortby:")
            }
            
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
    
    func sortBy(order: SortOrder) {
        switch order {
        case .alphabetical:
            resorts.sort { $0.name < $1.name }
        case .country:
            resorts.sort { $0.country < $1.country }
        case .defaultOrder:
            resorts = Bundle.main.decode("resorts.json")
        }
    }
}

#Preview {
    ContentView()
}
