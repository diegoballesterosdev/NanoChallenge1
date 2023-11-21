//
//  UnlockingView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 15/11/23.
//

import SwiftUI

struct UnlockingView: View {
    
    
    @ObservedObject var obsVar: ObsVar
    var title: String
    
    var body: some View {
        if obsVar.unlocked {
            GalleryView(obsVar: obsVar, title: title)
                .onDisappear() {
                    obsVar.unlocked = false
                }
        } else {
            LockedView(obsVar: obsVar)
        }
    }
}

