//
//  AddImageViewDetailsView.swift
//  Challenge6
//
//  Created by Harshit Singh on 4/22/25.
//

import SwiftUI

struct AddImageViewDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var users: [User]
    @State var image: Image
    @State var name: String = ""
    @FocusState var nameFocusState: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                HStack {
                    Text("Name:")
                    TextField("User name", text: $name, prompt: Text("User name"))
                        .focused($nameFocusState)
                }
                
                Spacer()
            }
            .padding(24)
            .navigationTitle("Add user")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: saveImage)
                }
            }
            .onSubmit(saveImage)
            .onAppear {
                nameFocusState = true
            }
        }
    }
    
    func saveImage() {
        guard !name.isEmpty else {
            return
        }
        users.append(User(name: name, image: image))
        dismiss()
    }
}

#Preview {
    AddImageViewDetailsView(users: .constant([]), image: Image(systemName: "plus"))
}
