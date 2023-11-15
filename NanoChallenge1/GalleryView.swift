//
//  GalleryView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI

struct GalleryView: View {
    @ObservedObject var obsVar: ObsVar
    
    //Allows to detect if the app is on background, active or inative
    @Environment(\.scenePhase) var scenePhase
   
    var body: some View {
        
        VStack {
            Text("Hidden album!")
            Button("Lock album") {
                obsVar.unlocked = false
            }
        }
        //We lock the screen if the app goes to background
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                obsVar.unlocked = false
                obsVar.inactive = true
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                obsVar.unlocked = false
            }
        }
    }
}

#Preview {
    GalleryView(obsVar: ObsVar())
}
