//
//  AddView.swift
//  iExpense
//
//  Created by Harshit Singh on 2/25/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0

    let types = ExpenseType.allCases
    @State var expenses: Expenses
    let currency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    save()
                }
            }
            .onSubmit {
                save()
            }
        }
    }
    
    func save() {
        let item = ExpenseItem(name: name, type: type, amount: amount, currencyLocal: currency)
        expenses.items.append(item)
        dismiss()
    }
}

#Preview {
    AddView(expenses: .init())
}
