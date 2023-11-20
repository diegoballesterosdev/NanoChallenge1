//
//  NanoChallenge1App.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct NanoChallenge1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(obsVar: ObsVar())
        }
        .modelContainer(for: ImageItem.self)
    }
}
