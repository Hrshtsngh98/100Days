//
//  ContentViewVM.swift
//  Challenge6
//
//  Created by Harshit Singh on 4/22/25.
//

import Foundation
import SwiftUICore

struct User: Identifiable, Comparable, Hashable {
    var id: UUID = UUID()
    let name: String
    let image: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}

extension ContentView {
    @Observable
    class ViewModel: ObservableObject {
        var users: [User] = []
    }
}
