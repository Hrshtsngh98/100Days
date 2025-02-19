//
//  TutorialView4.swift
//  Animations
//
//  Created by Harshit Singh on 2/19/25.
//

import SwiftUI

struct TutorialView4: View {
    @State private var dragAmount = CGSize.zero
    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.dragAmount = value.translation
                    }
                    .onEnded { value in
                        withAnimation(.bouncy) {
                            self.dragAmount = .zero
                        }
                    }
            )
//            .animation(.bouncy, value: dragAmount) // Adds animation to both dragging and ended
    }
}

#Preview {
    TutorialView4()
}
