//
//  TutorialView3.swift
//  CupcakeCorner
//
//  Created by Harshit Singh on 3/13/25.
//

import SwiftUI

struct TutorialView3: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
                .disabled(username.isEmpty || email.isEmpty)
            }
        }
    }
}

#Preview {
    TutorialView3()
}
