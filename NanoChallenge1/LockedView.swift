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
            Spacer()
            Text(text)
            
            
            Button("View Album") {
                authenticate()
            }
            
            Spacer()
            
            Button("Lock album") {
                unlocked = false
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check whether it's possible to use biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            // Handle events
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Your passcode is required to view this album") { success, authenticationError in
                
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
