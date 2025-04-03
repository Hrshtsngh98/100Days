//
//  TutorialView6.swift
//  Instafilter
//
//  Created by Harshit Singh on 4/3/25.
//

import StoreKit
import SwiftUI

struct TutorialView6: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)

        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check out the 100 Days of SwiftUI!"))

        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
            Label("Spread the word about Swift", systemImage: "swift")
        }
        
        let example = Image(.stars)

        ShareLink(item: example, preview: SharePreview("Stars", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
        
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    TutorialView6()
}
