//
//  ContentView.swift
//  Instafilter
//
//  Created by Harshit Singh on 4/1/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI
import StoreKit

struct ContentView: View {
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    
    @State private var filterIntensity = 0.0
    @State private var filterRadius = 0.0
    @State private var filterScale = 0.0
    
    // Sepiatone has a protocol CISepiaTone. So using CIFilter throws away some data.
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    @State private var showingFilters = false
    
    var disableChanges: Bool {
        processedImage == nil
    }

    //Heavy to create
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
//                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)

                Spacer()

                VStack {
                    let inputKeys = currentFilter.inputKeys

                    if inputKeys.contains(kCIInputIntensityKey) {
                        HStack {
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity, applyProcessing)
                                .disabled(disableChanges)
                        }
                    }
                    if inputKeys.contains(kCIInputRadiusKey) {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius)
                                .onChange(of: filterRadius, applyProcessing)
                                .disabled(disableChanges)
                        }
                    }
                    if inputKeys.contains(kCIInputScaleKey) {
                        HStack {
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale, applyProcessing)
                                .disabled(disableChanges)
                        }
                    }
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter", action: changeFilter)
                        .disabled(disableChanges)

                    Spacer()

                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Splash Distortion") { setFilter(CIFilter.circleSplashDistortion()) }
                Button("Pinch Distortion") { setFilter(CIFilter.pinchDistortion()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            
        }
    }
    
    func applyProcessing() {
//        currentFilter.intensity = Float(filterIntensity)
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    @MainActor
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 3 {
            requestReview()
            filterCount = 0
        }
    }
}

#Preview {
    ContentView()
}
