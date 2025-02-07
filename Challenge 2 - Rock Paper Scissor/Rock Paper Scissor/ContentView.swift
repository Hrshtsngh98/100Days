//
//  ContentView.swift
//  Rock Paper Scissor
//
//  Created by Harshit Singh on 2/7/25.
//

import SwiftUI

enum Option: String, CaseIterable {
    case rock
    case paper
    case scissor
    
    var image: some View {
        Group {
            switch self {
            case .rock:
                Image(systemName: "octagon.fill")
                    .foregroundStyle(.brown)
            case .paper:
                Image(systemName: "newspaper")
                    .foregroundStyle(.blue)
            case .scissor:
                Image(systemName: "scissors")
                    .foregroundStyle(.red)
            }
        }
    }
}

struct ContentView: View {
    @State private var cpuSelection = Option.allCases.randomElement()!
    @State private var playerShouldWin: Bool = .random()
        
    @State private var round: Int = 1
    @State private var score: Int = 0
    
    @State private var gameComplete: Bool = false
    @State private var roundComplete: Bool = false
    @State private var roundResult: String = ""
    
    private let totalGames: Int = 3
    
    var body: some View {
        VStack {
            Text("Round: \(round)")
                .font(.largeTitle)
                .padding(.top, 16)
            
            HStack {
                ForEach(Option.allCases, id: \.self) { option in
                    option.image
                        .font(.system(size: 80))
                }
            }
            .padding(.top, 16)
            
            HStack {
                Text("CPU Chose:")
                    .font(.title)
                cpuSelection.image
                    .font(.system(size: 40))
            }
            .padding(.top, 40)
            
            VStack(spacing: 0) {
                Group {
                    Text("You should ")
                        .font(.title)
                    +
                    Text(playerShouldWin ? "WIN" : "LOSE")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.top, 24)
                
            }
            .padding(.top, 40)
            
            Text("Select one")
                .font(.title)
                .padding(.top, 32)
            
            HStack(spacing: 32) {
                ForEach(Option.allCases, id: \.self) { option in
                    Button {
                        playerChose(option: option)
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.3))
                            option.image
                                .font(.system(size: 48))
                        }
                        .frame(width: 100)
                    }
                }
            }
            .padding(.top, 40)
            
            Text("Score: \(score)")
                .font(.largeTitle)
                .padding(.top, 40)
                .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [.white, .green], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .alert("Game complete!", isPresented: $gameComplete) {
            Button("Restart") {
                restartGame()
            }
        } message: {
            Text("Your score is: \(score)")
        }
        .alert(roundResult, isPresented: $roundComplete) {
            Button("OK") {
                if round >= totalGames {
                    gameComplete = true
                } else {
                    shuffle()
                }
            }
        }
    }
    
    func playerChose(option: Option) {
        if playerShouldWin {
            if (cpuSelection == .paper && option == .scissor) ||
                (cpuSelection == .rock && option == .paper) ||
                (cpuSelection == .scissor && option == .rock) {
                playerChoseCorrect()
            } else {
                playerChoseWrong()
            }
        } else {
            if (cpuSelection == .paper && option == .rock) ||
                (cpuSelection == .rock && option == .scissor) ||
                (cpuSelection == .scissor && option == .paper) {
                playerChoseCorrect()
            } else {
                playerChoseWrong()
            }
        }
    }
    
    func playerChoseCorrect() {
        score += 1
        roundResult = "WIN!"
        roundComplete = true
    }
    
    func playerChoseWrong() {
        score -= 1
        roundResult = "LOSE!"
        roundComplete = true
    }
    
    func shuffle() {
        round += 1
        cpuSelection = Option.allCases.randomElement()!
        playerShouldWin = .random()
    }

    func restartGame() {
        round = 1
        score = 0
        
        cpuSelection = Option.allCases.randomElement()!
        playerShouldWin = .random()
    }
}

#Preview {
    ContentView()
}
