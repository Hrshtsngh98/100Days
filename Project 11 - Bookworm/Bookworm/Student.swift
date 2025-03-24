//
//  Student.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/18/25.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
