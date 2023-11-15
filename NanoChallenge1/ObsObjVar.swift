//
//  ObsObjVar.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import Foundation

@MainActor class ObsVar: ObservableObject {
    //This ObservableObject changes the UI, and SwiftUI doesn't allow to do UI changes on backgrounds threads
    //Face ID authentication is running on background, not with MainActor, because it's done by the system and not by the app, so we need to let the App now that the changing of the unlocked var should be runned in the MainActor
    @Published var unlocked = false
    @Published var inactive = false
}
