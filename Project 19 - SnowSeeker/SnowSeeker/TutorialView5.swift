//
//  TutorialView5.swift
//  SnowSeeker
//
//  Created by Harshit Singh on 5/21/25.
//

import SwiftUI

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    @Environment(Player.self) var player: Player

    var body: some View {
        @Bindable var player = player
        
        VStack {
            Text("Your high score: \(player.highScore)")
            Stepper("High score: \(player.highScore)", value: $player.highScore)

        }
        .padding(20)
        
    }
}

struct TutorialView5: View {
    @State private var player = Player()

    var body: some View {
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)
    }
}

#Preview {
    TutorialView5()
}
