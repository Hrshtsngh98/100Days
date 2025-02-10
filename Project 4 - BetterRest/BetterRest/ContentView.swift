//
//  ContentView.swift
//  BetterRest
//
//  Created by Harshit Singh on 2/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp = Date.now

    
    var body: some View {
        VStack(spacing: 20) {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(.automatic)
            
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
    
    func exampleDate() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
        
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components)
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

#Preview {
    ContentView()
}
