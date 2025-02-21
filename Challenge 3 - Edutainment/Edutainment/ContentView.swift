//
//  ContentView.swift
//  Edutainment
//
//  Created by Harshit Singh on 2/21/25.
//

import SwiftUI

class GameData {
    let tableOf: Int
    let multiplicationBy: [Int]
    let correctAnswers: [Int]
    
    init(tableOf: Int, difficulty: DifficultyOption) {
        self.tableOf = tableOf
        
        var multiplicationBy: [Int] = []
        var correctAnswers: [Int] = []
        
        let range = 1...10
        for _ in 1...difficulty.numberOfQuestions {
            let element = range.randomElement() ?? 0
            
            multiplicationBy.append(element)
            correctAnswers.append(element*tableOf)
        }
        
        self.multiplicationBy = multiplicationBy
        self.correctAnswers = correctAnswers
    }
}

enum DifficultyOption: CaseIterable {
    case easy
    case medium
    case hard
    
    var numberOfQuestions: Int {
        switch self {
        case .easy:
            return 5
        case .medium:
            return 10
        case .hard:
            return 20
        }
    }
    
    var formatted: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
}

struct ContentView: View {
    let difficultyOptions: [DifficultyOption] = DifficultyOption.allCases
    
    @State private var selectedTable: Int = 0
    @State private var difficulty: DifficultyOption = .easy
    
    @State private var gameData: GameData?
    @State private var answerGiven: [String] = []
    
    @State private var isGameComplete = false
    
    var correctImage: some View {
        Image(systemName: "checkmark")
            .foregroundStyle(.green)
            .fontWeight(.bold)
            .font(.title)
    }
    
    var wrongImage: some View {
        Image(systemName: "xmark")
            .foregroundStyle(.red)
            .fontWeight(.bold)
            .font(.title)
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Select table", selection: $selectedTable) {
                    ForEach(2..<13) { option in
                        Text(option.formatted())
                    }
                }
                
                Picker("Select defficulty", selection: $difficulty) {
                    ForEach(difficultyOptions, id: \.self) { difficulty in
                        Text(difficulty.formatted)
                    }
                }
                
            } header: {
                Text("Select Options")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
            } footer: {
                Button("Start Game") {
                    withAnimation(.default) {
                        startGame()
                    }
                }
            }
            .onAppear() {
                //                startGame()
                //                completeGame()
            }
            
            if let gameData = gameData {
                Section {
                    ForEach(0..<difficulty.numberOfQuestions, id: \.self) { index in
                        let isAnswerCorrect = answerGiven[index] == gameData.correctAnswers[index].formatted()
                        
                        VStack() {
                            HStack {
                                Text(gameData.tableOf.formatted())
                                Text(" * ")
                                Text(gameData.multiplicationBy[index].formatted())
                                Text(" = ")
                                
                                TextField("answer", text: $answerGiven[index], prompt: Text("what do you think?"))
                                    .disabled(isGameComplete)
                                
                                if isGameComplete {
                                    if isAnswerCorrect {
                                        correctImage
                                    } else {
                                        wrongImage
                                    }
                                }
                            }
                            if isGameComplete && !isAnswerCorrect {
                                HStack {
                                    Text("Correct answer: ")
                                    Spacer()
                                    Text(gameData.correctAnswers[index].formatted())
                                    
                                    if isGameComplete && !isAnswerCorrect {
                                        correctImage
                                    }
                                }
                            }
                        }
                        
                    }
                } footer: {
                    Button("Complete") {
                        completeGame()
                    }
                }
            }
        }
    }
    
    func startGame() {
        isGameComplete = false
        gameData = .init(tableOf: selectedTable + 2, difficulty: difficulty)
        answerGiven = Array(repeating: "", count: difficulty.numberOfQuestions)
    }
    
    func completeGame() {
        isGameComplete = true
    }
}

#Preview {
    ContentView()
}
