//
//  LockedView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI
import LocalAuthentication

struct LockedView: View {
    
    @ObservedObject var obsVar: ObsVar
    
    
    
    
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
                
                Text("Use Face ID to View This Album")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            
            Button("View Album") {
                authenticate()
            }
            
            Spacer()
        }
        .onAppear() {
            if obsVar.inactive == false {
                authenticate()
            }
            
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check whether it's possible to use authentications
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            // Handle events
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Your Face ID is required to view this album") { success, authenticationError in
                
                if success {
                    
                    //Face ID authentication is running on background, not with MainActor, because it's done by the system and not by the app, so we need to let the App now that the changing of the unlocked var should be runned in the MainActor
                    Task {
                        await MainActor.run {
                            obsVar.unlocked = true
                        }
                    }
                }
            }
        }
        else {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Your passcode is required to view this album") { success, authenticationError in
                if success {
                    
                    Task {
                        await MainActor.run {
                            obsVar.unlocked = true
                        }
                    }
                }
            }
            
        }
    }
}


#Preview {
    LockedView(obsVar: ObsVar())
}
