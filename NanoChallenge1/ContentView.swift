//
//  ContentView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var obsVar: ObsVar
    var body: some View {
        if obsVar.unlocked {
            GalleryView(obsVar: obsVar)
        } else {
            LockedView(obsVar: obsVar)
        }
        
        
    }
    
}

#Preview {
    ContentView(obsVar: ObsVar())
}
