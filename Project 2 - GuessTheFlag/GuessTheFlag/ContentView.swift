//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Harshit Singh on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var gameOver = false
    @State private var gameCount = 1
    
    @State private var rotationDegrees: CGFloat = 0
    @State private var wrongAnswerScale: CGFloat = 1
    @State private var wrongAnswerOpacity: CGFloat = 1
    
    @State private var tappedFlagNumber: Int = -1
    
    let totalGames = 5
    
    var body: some View {
        ZStack {
            //            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    Spacer()
                    
                    Text("Guess the Flag")
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                    
                    VStack(spacing: 15) {
                        VStack {
                            Text("Tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(countries[correctAnswer])
                                .foregroundStyle(.black)
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { number in
                            FlagImage(flagImage: Image(countries[number])) {
                                tappedFlagNumber = number
                                
                                withAnimation(.linear, completionCriteria: .logicallyComplete) {
                                    rotationDegrees = 360
                                    wrongAnswerOpacity = 0.25
                                    wrongAnswerScale = 0.75
                                } completion: {
                                    flagTapped(number)
                                }
                            }
                            .rotation3DEffect(.degrees(tappedFlagNumber == number ? rotationDegrees : 0), axis: (0,1,0))
                            .opacity(tappedFlagNumber == number ? 1 : wrongAnswerOpacity)
                            .scaleEffect(tappedFlagNumber == number ? 1 : wrongAnswerScale)
//                            .animation(.linear, value: tappedFlagNumber)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    
                    Spacer()
                }
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                rotationDegrees = 0
                wrongAnswerOpacity = 1
                wrongAnswerScale = 1
                
                askQuestion()
            }
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score) / \(totalGames)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct!"
        } else {
            scoreTitle = "Wrong! The flag is for \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        gameCount += 1
        if gameCount <= totalGames {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            gameOver = true
        }
    }
    
    func restartGame() {
        gameCount = 1
        score = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
