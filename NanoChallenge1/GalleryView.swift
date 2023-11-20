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
    
    @Namespace var namespace
    
    //    @State var imageItem = ImageItem()
    @State var selectedPhoto: PhotosPickerItem?
    
    @Query private var imageItems: [ImageItem]
    
    @State private var selectedItem: Data?
    
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)
                ], spacing: 2) {
                    ForEach(imageItems.reversed()) { imageData in
                        let uiImage = UIImage(data: imageData.image!)
                        Image(uiImage: uiImage!)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                        
                        
                    }
                }
                .padding(2)
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
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                //                imageItem.image = data
                
                let item =  ImageItem(image: data)
                context.insert(item)
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
        
        Text("Hidden album!")
        
        Button("Lock album") {
            obsVar.unlocked = false
        }
        
    }
    
}





#Preview {
    GalleryView(obsVar: ObsVar())
}
