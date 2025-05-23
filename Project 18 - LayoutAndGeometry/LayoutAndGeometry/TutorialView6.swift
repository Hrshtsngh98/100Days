//
//  TutorialView6.swift
//  LayoutAndGeometry
//
//  Created by Harshit Singh on 5/14/25.
//

import SwiftUI

struct TutorialView6: View {
    //    var body: some View {
    //        ScrollView(.horizontal, showsIndicators: false) {
    //            HStack(spacing: 0) {
    //                ForEach(1..<20) { num in
    //                    GeometryReader { proxy in
    //                        Text("Number \(num)")
    //                            .font(.largeTitle)
    //                            .padding()
    //                            .background(.red)
    //                            .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
    //                            .frame(width: 200, height: 200)
    //                    }
    //                    .frame(width: 200, height: 200)
    //                }
    //            }
    //        }
    //    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    Text("Number \(num)")
                        .font(.largeTitle)
                        .padding()
                        .background(.red)
                        .frame(width: 200, height: 200)
                        .visualEffect { content, proxy in
                            content
                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    TutorialView6()
}
