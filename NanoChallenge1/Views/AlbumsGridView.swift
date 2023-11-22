//
//  AlbumsGridView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 17/11/23.
//

import SwiftUI
import SwiftData

struct AlbumsGridView: View {
    
    @Query private var imageItems: [ImageItem]
    
    @Environment(\.colorScheme) var colorScheme
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    let rows = [GridItem(.adaptive(minimum: 170))]
    
    var body: some View {
        ScrollView(.horizontal) {
            Section {
                LazyHGrid(rows: [GridItem(.flexible(minimum: 100, maximum: 170), spacing: 45),
                                 GridItem(.flexible(minimum: 100, maximum: 170), spacing: 20)]) {
                    ForEach(0..<9) { int in
                        
                        let randomInt = Int.random(in: 1..<100)
                        
                        NavigationLink {
                            GalleryView(obsVar: ObsVar(), title: "Album \(int+1)")
                        } label: {
                            VStack {
                                if imageItems.isEmpty {
                                    Image("Photo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .clipShape(.rect(cornerRadius: 5))
                                } else {
                                    let imageInt = Int.random(in: 0..<imageItems.count)
                                    let uiImage = UIImage(data: imageItems[imageInt].image!)
                                    Image(uiImage: uiImage!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipShape(.rect(cornerRadius: 5))
                                }
                                
                                HStack {
                                    Text("Album \(int+1)")
                                        .foregroundStyle(colorScheme == .light ? .black : .white)
                                    Spacer()
                                }
                                HStack {
                                    Text("\(imageItems.count)")
                                        .foregroundStyle(colorScheme == .light ? .black : .white)
                                        .opacity(0.7)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .accessibilityLabel("Album \(int+1), \(randomInt) photos")
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AlbumsGridView()
}
