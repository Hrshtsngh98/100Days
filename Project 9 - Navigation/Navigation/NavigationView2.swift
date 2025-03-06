//
//  NavigationView2.swift
//  Navigation
//
//  Created by Harshit Singh on 3/6/25.
//

import SwiftUI

struct NavigationView2: View {
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Button("Show 32") {
                    path = [32]
                }

                Button("Show 64") {
                    path.append(64)
                }
                
                Button("Show 32 then 64") {
                    path = [32, 64]
                }

            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

#Preview {
    NavigationView2()
}
