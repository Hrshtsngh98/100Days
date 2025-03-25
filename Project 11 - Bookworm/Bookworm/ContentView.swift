//
//  ContentView.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/18/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
//    @Query var books: [Book]
//    @Query(sort: \Book.title) var books: [Book]
//    @Query(sort: \Book.title, order: .reverse) var books: [Book]
//    @Query(sort: \Book.rating, order: .reverse) var books: [Book]
//    @Query(sort: [SortDescriptor(\Book.title)]) var books: [Book]
//    @Query(sort: [SortDescriptor(\Book.title, order: .reverse)]) var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]


    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
       }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]

            // delete it from the context
            modelContext.delete(book)
        }
    }
}

//#Preview {
//    ContentView(books: [])
//}
