//
//  ContentView.swift
//  iExpense
//
//  Created by Harshit Singh on 2/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.itemsToShow, id: \.0) { items in
                    Section {
                        ForEach(items.1) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type.rawValue)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: item.currencyLocal ?? "USD"))
                                    .foregroundStyle(item.amountColor)
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
        print(offsets)
    }
}

#Preview {
    ContentView()
}
