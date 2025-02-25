//
//  Expense.swift
//  iExpense
//
//  Created by Harshit Singh on 2/25/25.
//

import Foundation

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType: String, CaseIterable, Codable {
    case food = "Food"
    case transportation = "Transportation"
    case entertainment = "Entertainment"
    case clothing = "Clothing"
    case miscellaneous = "Miscellaneous"
    case personal = "Personal"
    case work = "Work"
}
