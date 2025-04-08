//
//  TutorialView3.swift
//  Bucket List
//
//  Created by Harshit Singh on 4/9/25.
//

import LocalAuthentication
import SwiftUI

struct TutorialView3: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    isUnlocked = true
                } else {
                    // there was a problem
                    isUnlocked = false
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    TutorialView3()
}
