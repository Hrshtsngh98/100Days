//
//  Extraview.swift
//  GuessTheFlag
//
//  Created by Harshit Singh on 1/31/25.
//

import SwiftUI

struct Extraview: View {
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//
//            Text("Your content")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(Material.ultraThinMaterial)
//        }
//        .ignoresSafeArea()
//    }
    
//    var body: some View {
//        LinearGradient(stops: [
//            Gradient.Stop(color: .white, location: 0.45),
//            Gradient.Stop(color: .black, location: 0.55),
//        ], startPoint: .top, endPoint: .bottom)
        
//        RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
        
//        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
//        
//        Text("Your content")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .foregroundStyle(.white)
//            .background(.red.gradient)
//    }
    
    var body: some View {
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    Extraview()
}
