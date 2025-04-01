//
//  TutorialView.swift
//  Instafilter
//
//  Created by Harshit Singh on 4/1/25.
//

import SwiftUI

struct TutorialView: View {
    @State private var blurAmount = 0.0

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .onChange(of: blurAmount) { oldValue, newValue in
            print("New value is \(blurAmount)")
        }
    }
}

#Preview {
    TutorialView()
}
