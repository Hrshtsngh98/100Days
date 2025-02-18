//
//  TutorialView.swift
//  Animations
//
//  Created by Harshit Singh on 2/18/25.
//

import SwiftUI

struct TutorialView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
                .onAppear {
                    animationAmount = 2
                }
        )
        
//        .animation(.linear, value: animationAmount)
//        .animation(.easeInOut, value: animationAmount)
//        .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
        .animation(
            .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true),
            value: animationAmount
        )
    }
}

#Preview {
    TutorialView()
}
