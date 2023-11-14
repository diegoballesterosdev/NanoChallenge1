//
//  GalleryView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI

struct GalleryView: View {
    @ObservedObject var obsVar: ObsVar
    //    @StateObject var locked = LockedView()
    
    
    
    
    var body: some View {
        
        VStack {
            Text("Hidden album!")
            Button("Lock album") {
                obsVar.unlocked = false
            }
        }
    }
}

#Preview {
    GalleryView(obsVar: ObsVar())
}
