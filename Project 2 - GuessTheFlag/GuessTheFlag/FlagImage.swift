//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Harshit Singh on 2/6/25.
//

import SwiftUI

struct FlagImage: View {
    var flagImage: Image
    var flagTapped: () -> Void
    
    var body: some View {
        Button {
            flagTapped()
        } label: {
            flagImage
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    FlagImage(flagImage: Image("UK")) {
        
    }
}
