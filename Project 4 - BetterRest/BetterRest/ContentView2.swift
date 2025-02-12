//
//  ContentView2.swift
//  BetterRest
//
//  Created by Harshit Singh on 2/12/25.
//

import CoreML
import SwiftUI

struct ContentView2: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var idealBedTime = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section("Daily coffee intake") {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(0..<21) { value in
                            Text("^[\(value) cup](inflect: true)")
                        }
                    }
                }
                
                Section("Your ideal bedtime is...") {
                    Text(idealBedTime)
                        .font(.largeTitle)
                }

            }
            .navigationTitle("BetterRest")
            .onAppear() {
                calculateBedtime()
            }
            .onChange(of: wakeUp, initial: false) { _, _ in
                calculateBedtime()
            }
            .onChange(of: sleepAmount, initial: false) { _, _ in
                calculateBedtime()
            }
            .onChange(of: coffeeAmount, initial: false) { _, _ in
                calculateBedtime()
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            idealBedTime = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            idealBedTime = "Sorry there was a problem calculating your bedtime"
        }
    }
}

#Preview {
    ContentView2()
}
