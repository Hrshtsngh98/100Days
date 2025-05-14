//
//  TutorialView3.swift
//  LayoutAndGeometry
//
//  Created by Harshit Singh on 5/14/25.
//

import SwiftUI

struct TutorialView3: View {
    var body: some View {
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)

            GeometryReader { proxy in
                Image(.example)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8)
                    .border(.red, width: 2)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .border(.red, width: 2)
            }
        }
    }
}

#Preview {
    TutorialView3()
}
