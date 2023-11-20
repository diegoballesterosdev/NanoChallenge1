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
    
    
    
    var body: some View {
        NavigationStack {
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
                        //                        Image(uiImage: uiImage!)
                        //                            .resizable()
                        //                            .scaledToFill()
                        //                            .frame(width: 128, height: 128)
                        //                            .clipped()
                        //                        
                        //                            .onTapGesture {
                        //                                selectedImage = Image(uiImage: uiImage!)
                        //                                isImageViewerPresented = true
                        //                            }
                        //                            .fullScreenCover(isPresented: $isImageViewerPresented) {
                        //                                if let selectedImage = selectedImage {
                        //                                    SwiftUIImageViewer(image: selectedImage)
                        //                                        .id(UUID())
                        //                                        .overlay(alignment: .topTrailing) {
                        //                                            Button {
                        //                                                isImageViewerPresented = false
                        //                                            } label: {
                        //                                                Image(systemName: "xmark")
                        //                                                    .font(.headline)
                        //                                            }
                        //                                            .buttonStyle(.bordered)
                        //                                            .clipShape(Circle())
                        //                                            .tint(.blue)
                        //                                            .padding()
                        //                                        }
                        //                                }
                        //                                
                        //                            }
                    }
                }
                .padding(2)
                
            }
            .padding(.top, 200)
            .ignoresSafeArea()
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

//#Preview {
//    GalleryView(obsVar: ObsVar(), selectedImage: Image)
//}
