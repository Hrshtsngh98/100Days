//
//  TutorialView7.swift
//  HotProspects
//
//  Created by Harshit Singh on 4/25/25.
//

import SamplePackage
import SwiftUI

struct TutorialView7: View {
    
    let possibleNumbers = 1...60

    var results: String {
        let selected = possibleNumbers.random(6).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        Text(results)
    }
}

#Preview {
    TutorialView7()
}
