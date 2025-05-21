//
//  TutorialView3.swift
//  SnowSeeker
//
//  Created by Harshit Singh on 5/21/25.
//

import SwiftUI

struct TutorialView3: View {
    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack(spacing: 40) {
            Button("Toggle Layout") {
                layoutVertically.toggle()
            }
            
            if layoutVertically {
                VStack {
                    testView
                }
            } else {
                HStack {
                    testView
                }
            }
            
            if horizontalSizeClass == .compact {
                VStack {
                    testView
                }
            } else {
                HStack {
                    testView
                }
            }
            
            ViewThatFits {
                Rectangle()
                    .frame(width: 500, height: 200)

                Circle()
                    .frame(width: 200, height: 200)
            }

        }
    }
    
    var testView: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

#Preview {
    TutorialView3()
}
