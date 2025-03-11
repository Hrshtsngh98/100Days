//
//  EditHabitView.swift
//  Track My Habit
//
//  Created by Harshit Singh on 3/11/25.
//

import SwiftUI

struct EditHabitView: View {
    @State var habit: Habit
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Name:")
                    .font(.headline)
                Text(habit.name)
            }
            
            VStack(alignment: .leading) {
                Text("About \(habit.name):")
                    .font(.headline)
                
                Text(habit.description ?? "- -")
            }
            
            VStack(alignment: .leading) {
                Text("Time spent:")
                    .font(.headline)
                
                Text(habit.spentTimeInToday.formatted())
            }
        }
        .listRowSeparator(.hidden)
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditHabitView(habit: .init(name: "Biking", description: "Aroind the lake", spentTimeInToday: 77))
}
