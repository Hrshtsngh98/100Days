//
//  Book.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/24/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var createdDate: Date
    
    var ratingColor: Color {
        switch rating {
        case 0, 1:
            return .red
        case 2, 3:
            return .orange
        case 4:
            return .yellow
        case 5:
            return .green
        default:
            return .gray
        }
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int, createdDate: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.createdDate = createdDate
    }
}
