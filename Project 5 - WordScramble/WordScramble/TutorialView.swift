//
//  TutorialView.swift
//  WordScramble
//
//  Created by Harshit Singh on 2/13/25.
//

import SwiftUI

struct TutorialView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }

            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
        .listStyle(.grouped)
        
        List(people, id: \.self) {
            Text("Dynamic \($0)")
        }
    }
}

#Preview {
    TutorialView()
}
