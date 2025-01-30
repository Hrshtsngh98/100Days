//
//  ContentView.swift
//  UnitConverter
//
//  Created by Harshit Singh on 1/30/25.
//

import SwiftUI

struct ContentView: View {
    enum Length: String, CaseIterable {
        case meters, kilometers, feet, yards, miles
    }
    
    let units = Length.allCases
    
    @State var selectedInputUnit: Length = .meters
    @State var selectedOutputUnit: Length = .feet
    
    @State var inputAmount: Double = 10.0
    @FocusState var inputAmountFocused
    
    var outputAmount: Double {
        if let index1 = units.firstIndex(of: selectedInputUnit),
            let index2 = units.firstIndex(of: selectedOutputUnit) {
            return inputAmount * factor[index1][index2]
        } else {
            return 0
        }
    }
    
    let factor: [[Double]] = [
        [1, 0.001, 3.28084, 1.0936, 0.0006213],
        [1000, 1, 3280.83, 1093.61, 0.6213],
        [0.3048, 0.0003048, 1, 0.333, 0.000189],
        [0.9144, 0.0009144, 3.0, 1, 0.000568],
        [1609.34, 1.60934, 5280, 1760, 1],
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    Picker("Input Unit", selection: $selectedInputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    
                    TextField("1000", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputAmountFocused)
                }
                
                Section("Output") {
                    Picker("Output Unit", selection: $selectedOutputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }

                    Text("\(outputAmount.formatted()) \(selectedOutputUnit.rawValue)")
                }
            }
            .navigationTitle("Convert length")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if inputAmountFocused {
                    Button("Done") {
                        inputAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
