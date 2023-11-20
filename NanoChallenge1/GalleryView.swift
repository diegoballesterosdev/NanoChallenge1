//
//  GalleryView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI
import PhotosUI
import SwiftData

struct GalleryView: View {
    @ObservedObject var obsVar: ObsVar
    
    //Allows to detect if the app is on background, active or inative
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) private var context
    
//    @State var imageItem = ImageItem()
    @State var selectedPhoto: PhotosPickerItem?
    
    @Query private var items: [ImageItem]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    ForEach(items){ item in
                        let uiImage = UIImage(data: item.image!)
                        Image(uiImage: uiImage!)
                        
                    }
                }
//                if let imageData = imageItem.image,
//                   let uiImage = UIImage(data: imageData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFit()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity, maxHeight: 300)
//                    
//                }
                
                
                
                
                Text("Hidden album!")
                
                Button("Lock album") {
                    obsVar.unlocked = false
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $selectedPhoto,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Label("Add Image", systemImage: "photo")
                    }
                }
            }
        }
        //We lock the screen if the app goes to background
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                obsVar.unlocked = false
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                obsVar.unlocked = false
            }
        }
        .task(id: selectedPhoto) {		
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
//                imageItem.image = data
                
                let item =  ImageItem(image: data)
                context.insert(item)
            }
           
        }
    }
}

#Preview {
    GalleryView(obsVar: ObsVar())
}
