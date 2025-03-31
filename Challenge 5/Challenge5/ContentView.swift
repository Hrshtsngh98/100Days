//
//  ContentView.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/30/25.
//

import SwiftUI

struct ContentView: View {
    @State var path: NavigationPath = .init()
    @State var users: [User] = []
    
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
                    await getData()
                }
            }
        }
    }
    
    func getData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            self.users = try jsonDecoder.decode([User].self, from: data)
        } catch {
            
        }
    }
}

#Preview {
    ContentView(users: [User.example])
}
