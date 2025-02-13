//
//  TutorialView2.swift
//  WordScramble
//
//  Created by Harshit Singh on 2/13/25.
//

import SwiftUI

struct TutorialView2: View {
    @State private var data: [String] = []
    var body: some View {
        List(data, id: \.self) { text in
            Text(text)
        }
        .onAppear {
            testBundles()
        }
    }
    
    func testBundles() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // we found the file in our bundle!
            if let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) {
                // we loaded the file into a string!
                data = fileContents.components(separatedBy: .newlines)
            }
        }
    }
    
    func testString() {
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)

        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
    }
}

#Preview {
    TutorialView2()
}
 
