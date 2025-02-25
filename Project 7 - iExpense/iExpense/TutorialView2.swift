//
//  TutorialView2.swift
//  iExpense
//
//  Created by Harshit Singh on 2/25/25.
//

import SwiftUI

// Codable to archive/unarchive
struct User: Codable {
    let firstName: String
    let lastName: String
}

struct TutorialView2: View {
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    TutorialView2()
}
