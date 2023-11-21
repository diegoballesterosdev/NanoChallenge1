//
//  GalleryView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 14/11/23.
//

import SwiftUI
import PhotosUI
import SwiftData
import SwiftUIImageViewer

struct GalleryView: View {
    @ObservedObject var obsVar: ObsVar
    
    //Allows to detect if the app is on background, active or inative
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) private var context
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var isImageViewerPresented = false
    @State private var selectedImage: Image?
    
    
    @Query private var imageItems: [ImageItem]
    
    @State private var selectedItem: Data?
    
    var title: String
    
    
    
    var body: some View {
//        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)
                ], spacing: 2) {
                    ForEach(imageItems, id: \.id) { imageData in
                        let uiImage = UIImage(data: imageData.image!)
                        NavigationLink(destination: SwiftUIImageViewer(image: Image(uiImage: uiImage!))) {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .clipped()
                        }
                        
                    }
                }
                .padding(2)
                
            }
//        }
        .navigationTitle(title)
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
        
    }
    
}

#Preview {
    GalleryView(obsVar: ObsVar(), title: "Album")
}
