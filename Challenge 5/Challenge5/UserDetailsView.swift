//
//  UserDetailsView.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/31/25.
//

import SwiftUI

struct UserDetailsView: View {
    @Binding var path: NavigationPath
    var user: User
    
    let activeColor = Color.green.opacity(0.3)
    let inActiveColor = Color.red.opacity(0.3)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                basicInfoView
                moreInfoView
            }
            .padding()
            .navigationTitle(user.name)
            .toolbarRole(.editor)
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(user.isActive ? activeColor : inActiveColor, for: .navigationBar)
        }
        .frame(maxWidth: .infinity)
        .background(user.isActive ? activeColor : inActiveColor)
    }
    
    private var basicInfoView: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Age:")
                    .font(.headline)
                Text("\(user.age)")
            }
            
            HStack(alignment: .top) {
                Text("Email:")
                    .font(.headline)
                Text("\(user.email)")
            }
            
            HStack(alignment: .top) {
                Text("Company:")
                    .font(.headline)
                Text("\(user.company)")
            }
            
            HStack(alignment: .top) {
                Text("Address:")
                    .font(.headline)
                Text("\(user.address)")
            }
            
            HStack(alignment: .top) {
                Text("Registerd Date:")
                    .font(.headline)
                Text("\(user.registered.formatted(date: .abbreviated, time: .omitted))")
            }
        }
    }
    
    private var moreInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                Text("About")
                    .font(.headline)
                Text(user.about)
                    .font(.caption)
            }
            .padding(.top, 24)
            
            VStack(alignment: .leading) {
                Text("Tags")
                    .font(.headline)
                
                HStack {
                    Text(user.tags.joined(separator: ", "))
                        .font(.caption)
                }
            }
            .padding(.top, 24)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Friends")
                    .font(.headline)
                
                VStack(spacing: 0) {
                    ForEach(0..<user.friends.count) { pos in
                        HStack {
                            Text(user.friends[pos].name)
                                .font(.caption)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 4, height: 8)
                                .foregroundStyle(.gray)
                        }
                        .padding(4)
                        .background(pos % 2 == 0 ? Color.gray.opacity(0.2) : Color.clear)
                        .onTapGesture {
                            path.append(user.friends[pos])
                        }
                    }
                }
            }
            .padding(.top, 24)
        }
    }
}

#Preview {
    NavigationStack {
        UserDetailsView(path: .constant(.init()), user: .example)
    }
}
