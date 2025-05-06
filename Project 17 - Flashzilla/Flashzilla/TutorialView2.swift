//
//  TutorialView2.swift
//  Flashzilla
//
//  Created by Harshit Singh on 5/6/25.
//

import SwiftUI

struct TutorialView2: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(.rect) // consider rectangle area as square
                .onTapGesture {
                    print("Circle tapped!")
                }
//                .allowsHitTesting(false) // ignores the circle in front
                
        }
    }
}

#Preview {
    TutorialView2()
}
