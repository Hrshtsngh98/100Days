//
//  TutorialView5.swift
//  Instafilter
//
//  Created by Harshit Singh on 4/3/25.
//

import PhotosUI
import SwiftUI

struct TutorialView5: View {
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerItems: [PhotosPickerItem] = []
    
    @State private var selectedImage: Image?
    @State private var selectedImages: [Image] = []
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select", systemImage: "photo.artframe")
            }
            
            selectedImage?
                .resizable()
                .scaledToFit()
            
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    do {
                        if let loadedImage = try await item.loadTransferable(type: Image.self) {
                            selectedImages.append(loadedImage)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    TutorialView5()
}
