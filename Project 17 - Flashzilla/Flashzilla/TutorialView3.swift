//
//  TutorialView3.swift
//  Flashzilla
//
//  Created by Harshit Singh on 5/6/25.
//

import Combine
import SwiftUI

struct TutorialView3: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var counter = 0
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onReceive(timer) { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time)")
                    }
                    
                    counter += 1
                }
            
            Text("Hello, World!")
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    if newPhase == .active {
                        print("Active")
                    } else if newPhase == .inactive {
                        print("Inactive")
                    } else if newPhase == .background {
                        print("Background")
                    } else {
                        print(newPhase.hashValue)
                    }
                }
        }
    }
}

#Preview {
    TutorialView3()
}
