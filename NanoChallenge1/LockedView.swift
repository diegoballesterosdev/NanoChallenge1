//
//  LockedView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI
import LocalAuthentication

struct LockedView: View {
    @State private var unlocked = false
    @State private var text = "LOCKED"
    
    
    var body: some View {
        VStack {
            Text(text)
            
            
            Button("View Album") {
                authenticate()
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check whether it's possible to use biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            // Handle events
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is a security check reason.") { success, authenticationError in
                
                if success {
                    text = "UNLOCKED"
                } else {
                    text = "There was a problem!"
                }
            }
        } else {
            text = "Phone does not have biometrics"
        }
    }
}


#Preview {
    LockedView()
}
