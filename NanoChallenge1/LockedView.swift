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
    @State private var passcode = false
    @State private var text = "Use Face ID to View This Album"
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .opacity(0.6)
                    .padding(10)
                
                Text(text)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            
            
            
            Button("View Album") {
                authenticate()
            }
            
            Spacer()
            
            Button("Lock album") {
                unlocked = false
                text = "LOCKED"
            }
        }
        .onAppear() {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check whether it's possible to use authentications
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            // Handle events
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Your passcode is required to view this album") { success, authenticationError in
                
                if success && passcode {
                    text = "UNLOCKED"
                } else {
                    text = "Use Your Passcode to View This Album"
//                    passcode = true
                }
            }
        } else {
            text = "Cannot authenticate"
            
        }
    }
}


#Preview {
    LockedView()
}
