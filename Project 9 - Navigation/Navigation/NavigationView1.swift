//
//  NavigationView1.swift
//  Navigation
//
//  Created by Harshit Singh on 3/5/25.
//

import SwiftUI

struct Student: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct NavigationView1: View {
    let students = [Student(name: "Harry", age: 25), Student(name: "Ron", age: 24), Student(name: "Hermione", age: 23)]
    
    var body: some View {
        NavigationStack {
            ForEach(students) { student in
                NavigationLink("\(student.name)", value: student)
                    .navigationDestination(for: Student.self) { student in
                        Text(student.name)
                    }
                    .padding()
            }
        }
    }
}

#Preview {
    NavigationView1()
}
