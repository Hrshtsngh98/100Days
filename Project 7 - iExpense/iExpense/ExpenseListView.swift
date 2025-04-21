//
//  ContentView.swift
//  iExpense
//
//  Created by Harshit Singh on 2/25/25.
//

import SwiftUI

struct ExpenseListView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<expenses.itemsToShow.count) { index in
                    Section {
                        ForEach(expenses.itemsToShow[index]) { item in
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
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(Text("\(item.type.rawValue) expense item: \(item.name) of value"))
                            .accessibilityHint(Text(item.amount, format: .currency(code: item.currencyLocal ?? "USD")))
                        }
                        .onDelete { indexSet in
                            expenses.removeItem(section: index, at: indexSet)
                        }
                    }
                }
            }
            .toolbar {
                // Day 46 - change buttom to Navigation link
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                     Button("Add Expense", systemImage: "plus") {
//                          showingAddExpense = true
                     }
                }
                

            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
}

#Preview {
    ExpenseListView()
}
