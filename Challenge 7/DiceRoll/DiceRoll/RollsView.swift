//
//  RollsView.swift
//  DiceRoll
//
//  Created by Harshit Singh on 5/16/25.
//

import SwiftUI

struct RollsView: View {
    @State var shuffledData: [ShuffleData]
    
    var body: some View {
        VStack {
            if shuffledData.isEmpty {
                VStack {
                    Image(systemName: "dice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("You never rolled!")
                        .font(.largeTitle)
                }
                .foregroundColor(.gray)
            } else {
                List {
                    ForEach(shuffledData, id: \.id) { shuffle in
                        Section("Roll") {
                            ForEach(Array(shuffle.diceValues.enumerated()), id: \.offset) { diceNumber, diceValue in
                                Group {
                                    HStack {
                                        Text("Dice \(diceNumber)")
                                        Spacer()
                                        Text("\(diceValue)")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Rolls View")
    }
}

struct RollsView_Previews: PreviewProvider {
    static var previews: some View {
        RollsView(shuffledData: [])
    }
}
