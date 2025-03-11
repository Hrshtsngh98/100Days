//
//  Habit.swift
//  Track My Habit
//
//  Created by Harshit Singh on 3/11/25.
//

import Foundation
import SwiftUI

struct Habit: Codable, Identifiable, Hashable {
    var id = UUID()

    var name: String
    var description: String?
    var spentTimeInToday: Int
}

@Observable
class HabitManager {
    static let saveHabitsKey: String = "saveHabitsKey"
    
    var habits: [Habit] = [] {
        didSet {
            saveHabit()
        }
    }
    
    init() {
        loadHabits()
    }
    
    private func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: Self.saveHabitsKey) {
            do {
                self.habits = try JSONDecoder().decode([Habit].self, from: savedData)
            } catch {
                print("Error loading habits: \(error)")
                self.habits = []
            }
        }
    }
    
    private func saveHabit() {
        do {
            let savedData = try JSONEncoder().encode(habits)
            UserDefaults.standard.set(savedData, forKey: Self.saveHabitsKey)
        } catch {
            print("Error saving habits: \(error)")
        }
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
    func deleteHabit(indexSet: IndexSet) {
        habits.remove(atOffsets: indexSet)
    }
}
