//
//  TutorialView3.swift
//  Animations
//
//  Created by Harshit Singh on 2/18/25.
//

import SwiftUI

struct TutorialView3: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var isShowingRed = false

    var body: some View {
        VStack(spacing: 40) {
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
            
            Button("Tap Me") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(.default, value: enabled)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
            .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
            
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
//                        .transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
        }
    }
}

#Preview {
    TutorialView3()
}
