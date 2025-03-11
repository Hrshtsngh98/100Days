//
//  AddHabit.swift
//  Track My Habit
//
//  Created by Harshit Singh on 3/11/25.
//

import SwiftUI

struct AddHabit: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var manager: HabitManager
    @State var name: String = ""
    @State var description: String = ""
    @State var time: Int = 5
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Activity name", text: $name)
                    .frame(height: 40)
                
                TextField("About this activity", text: $description)
                    .frame(height: 40)
                
                Stepper("Time spent: \(time.formatted()) mins", value: $time, in: 5...200, step: 5)
                    .frame(height: 40)
            }
            .listRowSeparator(.hidden)
            .navigationTitle("Add new habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        manager.addHabit(.init(name: name, description: description, spentTimeInToday: time))
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHabit(manager: .constant(.init()))
}
