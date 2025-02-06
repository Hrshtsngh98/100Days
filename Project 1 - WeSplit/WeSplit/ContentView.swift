//
//  ContentView.swift
//  WeSplit
//
//  Created by Harshit Singh on 1/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages1: [Int] = [10, 15, 20, 25, 30, 0]
    private let tipPercentages2: [Int] = Array(0..<101)
    
    var totalAmount: Double {
        let tipAmount = checkAmount * Double(tipPercentage) / 100
        let totalWithTip = checkAmount + tipAmount
        return totalWithTip
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) + 2
        return totalAmount / Double(peopleCount)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                // Part 2
                // Section("How much do you want to tip?") {
                //     Picker("Tip percentage", selection: $tipPercentage) {
                //         ForEach(tipPercentages1, id: \.self) {
                //             Text($0, format: .percent)
                //         }
                //     }
                //     .pickerStyle(.segmented)
                // }
                
                // Part 3
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages2, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
