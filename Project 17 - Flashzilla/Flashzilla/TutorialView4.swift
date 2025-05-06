//
//  TutorialView4.swift
//  Flashzilla
//
//  Created by Harshit Singh on 5/6/25.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct TutorialView4: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    @State private var scale = 1.0

    var body: some View {
        VStack(spacing: 80) {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? .black : .green)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
            Button("Hello, World!") {
                //            if reduceMotion {
                //                scale *= 1.5
                //            } else {
                //                withAnimation {
                //                    scale *= 1.5
                //                }
                //            }
                
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
            .scaleEffect(scale)
            
            Text("Hello, World!")
                .padding(50)
                .background(reduceTransparency ? .black : .black.opacity(0.5))
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }

    }
}

#Preview {
    TutorialView4()
}
