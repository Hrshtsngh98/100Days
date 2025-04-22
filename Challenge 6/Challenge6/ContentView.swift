//
//  ContentView.swift
//  Challenge6
//
//  Created by Harshit Singh on 4/22/25.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var viewModel = ViewModel()
    @State private var imagePickerItem: PhotosPickerItem?
    @State private var showAddDetails: Bool = false
    @State private var image: Image?
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if viewModel.users.isEmpty {
                    PhotosPicker(selection: $imagePickerItem, matching: .images, preferredItemEncoding: .automatic) {
                        ContentUnavailableView("No users", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                } else {
                    ScrollView {
                        ForEach(viewModel.users.sorted()) { user in
                            NavigationLink(value: user) {
                                HStack(alignment: .top, spacing: 12) {
                                    user.image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))

                                    Text(user.name)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            PhotosPicker(selection: $imagePickerItem, matching: .images, preferredItemEncoding: .automatic) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .navigationDestination(for: User.self) { user in
                        VStack {
                            user.image
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .navigationTitle(user.name)                        
                    }
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: imagePickerItem, { _, _ in
                Task { @MainActor in
                    if let imageData = try await imagePickerItem?.loadTransferable(type: Data.self),
                       let inputImage = UIImage(data: imageData) {
                        self.image = Image(uiImage: inputImage)
                        self.imagePickerItem = nil
                        showAddDetails = true
                    }
                }
            })
            .sheet(isPresented: $showAddDetails) {
                if let image {
                    AddImageViewDetailsView(users: $viewModel.users, image: image)
                } else {
                    AddImageViewDetailsView(users: $viewModel.users, image: Image(systemName: "person"))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
