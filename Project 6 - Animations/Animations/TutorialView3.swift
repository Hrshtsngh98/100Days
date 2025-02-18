//
//  TutorialView3.swift
//  Animations
//
//  Created by Harshit Singh on 2/18/25.
//

import SwiftUI

struct TutorialView3: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

    }
}

#Preview {
    TutorialView3()
}
