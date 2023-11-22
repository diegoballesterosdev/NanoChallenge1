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
            
            AlbumsView(obsVar: ObsVar())
                .tabItem {
                    Label("Albums", systemImage: "rectangle.stack.fill")
                }
        
    }
}

#Preview {
    ContentView(obsVar: ObsVar())
}
