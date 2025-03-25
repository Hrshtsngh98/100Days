//
//  AddBookView.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/24/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var showError = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)

                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) {
                            Text(String($0))
                        }
                    }
                    
                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        if isValid() {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, createdDate: .now)
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            showError = true
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Invalid book name", isPresented: $showError) {
                
            }
        }
    }
    
    
    func isValid() -> Bool {
        return !(title.isEmpty ||
                 author.isEmpty ||
                 review.isEmpty ||
                 rating == 0 ||
                 genre.isEmpty)
    }
}

#Preview {
    AddBookView()
}
