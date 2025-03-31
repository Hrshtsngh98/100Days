//
//  ContentView.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/30/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var path: NavigationPath = .init()
    @Query var users: [User]
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                UserListItemView(user: user)
                    .onTapGesture {
                        path.append(user)
                    }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserDetailsView(path: $path, user: user)
            }
            .navigationDestination(for: Friend.self) { friend in
                if let user = users.first(where: { $0.id == friend.id }) {
                    UserDetailsView(path: $path, user: user)
                }
            }
        }
        .accentColor(.black)
        .onAppear {
            Task {
                if users.isEmpty {
                    let users = await fetchData()
                    saveUser(users: users)
                }
            }
        }
    }
    
    func fetchData() async -> [User] {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let newUsers = try jsonDecoder.decode([User].self, from: data)
            return newUsers
        } catch {
            return []
        }
    }
    
    func saveUser(users: [User]) {
        for user in users {
            modelContext.insert(user)
            
            for friend in user.friends {
                modelContext.insert(friend)
            }
        }
    }
}

#Preview {
    ContentView()
}
