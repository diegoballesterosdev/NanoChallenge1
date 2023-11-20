//
//  ImageItem.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 20/11/23.
//

import Foundation
import SwiftData

@Model
class ImageItem: Identifiable {
    
    var id: String
    var fav: Bool
    var image: Data?
    
    init(image: Data) {
        id = UUID().uuidString
        self.fav = false
        self.image = image
    }
    
}
