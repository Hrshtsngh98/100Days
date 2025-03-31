//
//  UserListItemView.swift
//  Challenge5
//
//  Created by Harshit Singh on 3/31/25.
//

import SwiftUI

struct UserListItemView: View {
    var user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(user.name)
                    .foregroundStyle(user.isActive ? .green : .red)
                    .font(.headline)
                
                Text("\(user.company)")
                    .font(.caption)
                Text("\(user.email)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    ContentView()
}
