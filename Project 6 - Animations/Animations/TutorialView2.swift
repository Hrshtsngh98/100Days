//
//  TutorialView2.swift
//  Animations
//
//  Created by Harshit Singh on 2/18/25.
//

import SwiftUI

struct TutorialView2: View {
    @State var animationAmount: Double = 1
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
        }    }
}

#Preview {
    TutorialView2()
}
