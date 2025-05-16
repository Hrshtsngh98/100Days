//
//  ContentView.swift
//  DiceRoll
//
//  Created by Harshit Singh on 5/16/25.
//

import SwiftUI

struct DiceView: View {
    let diceRange = [4, 6, 10, 12, 20, 100]
        
    @State private var numberOfSides = 4
    @State private var numberOfDice = 4
    
    @State private var shuffledData: [ShuffleData] = []
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("My Rolls") {
                        RollsView(shuffledData: shuffledData)
                    }
                }
                Section("Select and roll") {
                    Picker("Select Dice Sides", selection: $numberOfSides) {
                        ForEach(0..<diceRange.count, id: \.self ) { val in
                            Text("\(diceRange[val])")
                        }
                    }
                    
                    Picker("Number of Dice", selection: $numberOfDice) {
                        ForEach(1..<7, id: \.self) { val in
                            Text("\(val)")
                        }
                    }
                    
                    HStack(alignment: .center) {
                        Button("Shuffle", action: shuffleDice)
                    }
                }
                
                if let data = shuffledData.last {
                    Section("Current roll") {
                        ForEach(1..<data.diceValues.count+1, id: \.self) { value in
                            HStack {
                                Text("Dice \(value)")
                                Spacer()
                                Text("\(data.diceValues[value-1])")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Dice Roll")
        }
    }
    
    func getRandomDiceValue() -> Int {
        Int.random(in: 1...diceRange[numberOfSides])
    }
    
    func shuffleDice() {
        var newValues: [Int] = []
        for _ in 0..<numberOfDice {
            newValues.append(getRandomDiceValue())
        }
        let newShuffledData = ShuffleData(diceValues: newValues)
        shuffledData.append(newShuffledData)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
