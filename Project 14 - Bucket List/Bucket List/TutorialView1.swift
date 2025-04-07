//
//  TutorialView1.swift
//  Bucket List
//
//  Created by Harshit Singh on 4/7/25.
//

import SwiftUI

struct TutorialView1: View {
    var body: some View {
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")

            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    TutorialView1()
}
