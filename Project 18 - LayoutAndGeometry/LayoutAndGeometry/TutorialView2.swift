//
//  TutorialView2.swift
//  LayoutAndGeometry
//
//  Created by Harshit Singh on 5/14/25.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct TutorialView2: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            .border(Color.green, width: 1)

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
            }
            .border(Color.red, width: 1)
        }
        .border(Color.black, width: 1)
    }
}

#Preview {
    TutorialView2()
}
