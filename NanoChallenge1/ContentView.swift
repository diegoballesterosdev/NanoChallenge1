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

    }
}

#Preview {
    ContentView(obsVar: ObsVar())
}
