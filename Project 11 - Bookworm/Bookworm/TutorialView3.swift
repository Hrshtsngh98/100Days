//
//  TutorialView3.swift
//  Bookworm
//
//  Created by Harshit Singh on 3/18/25.
//

import SwiftUI
import SwiftData

struct TutorialView3: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    
                    modelContext.insert(student)
                    
                }
            }
        }
    }
}

#Preview {
    TutorialView3()
}
