//
//  TutorialView2.swift
//  SnowSeeker
//
//  Created by Harshit Singh on 5/21/25.
//

import SwiftUI

struct User: Identifiable {
    let id = "Something"
}

struct TutorialView2: View {
    @State var something: User?
    
    var body: some View {
        VStack {
            Button("Show sheet") {
                something = .init()
            }
        }
        .navigationTitle("Content View")
        .sheet(item: $something) { val in
            Text(val.id)
                .presentationDetents([.large, .medium])
        }
    }
}

#Preview {
    TutorialView2()
}
