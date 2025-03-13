//
//  TutorialView2.swift
//  CupcakeCorner
//
//  Created by Harshit Singh on 3/13/25.
//

import SwiftUI

struct TutorialView2: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.red
            }
            .frame(width: 200, height: 200)
            
            AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    TutorialView2()
}
