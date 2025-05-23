//
//  TutorialView.swift
//  HotProspects
//
//  Created by Harshit Singh on 4/24/25.
//

import SwiftUI

struct TutorialView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    
    
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        
        if selection.isEmpty == false {
            Text("You selected \(selection.formatted())")
        }
        
        EditButton()
    }
}

#Preview {
    TutorialView()
}
