//
//  EditView.swift
//  Bucket List
//
//  Created by Harshit Singh on 4/9/25.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: EditView.ViewModel
    var onSave: (Location) -> Void
    var onDelete: (Location) -> Void
    
    init(vm: EditView.ViewModel, onSave: @escaping (Location) -> Void, onDelete: @escaping (Location) -> Void) {
        self.viewModel = vm
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section {
                    Button(role: .destructive) {
                        onDelete(viewModel.location)
                    } label: {
                        Text("Delete")
                    }
                    .font(.headline)

                }
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.save()
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditView(vm: .init(location: .example)) { location in
        
    } onDelete: { location in
        
    }

}
