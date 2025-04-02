//
//  TutorialView3.swift
//  Instafilter
//
//  Created by Harshit Singh on 4/3/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct TutorialView3: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        let inputImage = UIImage(resource: .stars)
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
//        let currentFilter = CIFilter.twirlDistortion()
//        let currentFilter = CIFilter.sepiaTone()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: beginImage!.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    TutorialView3()
}
