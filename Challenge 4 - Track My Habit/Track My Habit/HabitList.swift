//
//  HabitList.swift
//  Track My Habit
//
//  Created by Harshit Singh on 3/11/25.
//

import SwiftUI

struct HabitList: View {
    @State var path: NavigationPath = .init()
    @State var manager: HabitManager = .init()
    @State var showAddHabit: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(manager.habits) { habit in
                    habitItemView(habit)
                        .onTapGesture {
                            path.append(habit)
                        }
                }
                .onDelete { indexSet in
                    manager.deleteHabit(indexSet: indexSet)
                }
            }
            .navigationTitle("Track my habit")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Track new activity") {
                        showAddHabit = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabit(manager: $manager)
            }
            .navigationDestination(for: Habit.self) { habit in
                EditHabitView(habit: habit)
            }
        }
    }
    
    func habitItemView(_ habit: Habit) -> some View {
        HStack {
            Text(habit.name)
                .font(.headline)
            
            Spacer()
            
            Text("\(habit.spentTimeInToday) min")
            
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    HabitList()
}
