//
//  TutorialView2.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/18/25.
//

import SwiftUI

struct TutorialView2: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            TextField("Enter your text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    TutorialView2()
}
