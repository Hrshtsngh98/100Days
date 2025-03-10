//
//  Expense.swift
//  iExpense
//
//  Created by Harshit Singh on 2/25/25.
//

import Foundation
import SwiftUICore

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var itemsToShow: [[ExpenseItem]] {
        let newList1 = items.filter({ $0.type == .personal })
        let newList2 = items.filter({ $0.type == .work })
        
        return [newList1, newList2]
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            UserDefaults.standard.set(savedItems, forKey: "Backup Items")
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    func removeItem(section: Int, at offsets: IndexSet) {
        if let offset = offsets.first {
            let item = itemsToShow[section][offset]
            items.removeAll { $0.id == item.id }
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
    let currencyLocal: String?
    
    var amountColor: Color {
        if amount < 10 {
            return .green
        } else if amount < 50 {
            return .orange
        } else {
            return .red
        }
    }
}

enum ExpenseType: String, CaseIterable, Codable {
    case personal = "Personal"
    case work = "Work"
}
