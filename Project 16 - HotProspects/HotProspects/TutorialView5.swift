//
//  TutorialView5.swift
//  HotProspects
//
//  Created by Harshit Singh on 4/25/25.
//

import SwiftUI

struct TutorialView5: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deleting")
                    }
                    
                    Button("Message", systemImage: "message") {
                        print("Hi")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    TutorialView5()
}
