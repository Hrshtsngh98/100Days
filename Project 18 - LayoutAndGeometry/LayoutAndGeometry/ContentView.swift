//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Harshit Singh on 5/14/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(
                                    hue: min(1, Double.random(in: 0...1)),
                                    saturation: 1,
                                    brightness: 1
                                )
                            )
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(Double(1 - (200 - proxy.frame(in: .global).minY) / 200))
                            .scaleEffect(
                                max(0.5, Double(proxy.frame(in: .global).midY / fullView.frame(in: .global).height))
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
