//
//  ImageViewer.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 20/11/23.
//

import SwiftUI
import SwiftData
import SwiftUIImageViewer

struct ImageViewer: View {
    
    
    let image: Image
    let imageItem: ImageItem
    @Environment(\.modelContext) private var context
    @Binding var isPresented: Bool
    @Query private var imageItems: [ImageItem]
    

    var body: some View {
        SwiftUIImageViewer(image: image)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button {
                            context.delete(imageItem)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    
                }
                
            }
            
        
    }
}

//#Preview {
//    ImageViewer()
//}
