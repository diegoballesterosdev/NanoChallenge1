//
//  AlbumsView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 15/11/23.
//

import SwiftUI

struct AlbumsView: View {
    
    struct ListItem: Identifiable {
        let name: String
        let image: String
        let size: Int
        let id = UUID()
    }
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @Environment(\.dynamicTypeSize) var typeSize
    
    @ObservedObject var obsVar: ObsVar
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    let rows = [GridItem(.adaptive(minimum: 150, maximum: 150))]
    
    private let listItems: [ListItem] = [
        ListItem(name: "Imports", image: "square.and.arrow.down", size: 20),
        ListItem(name: "Hidden", image: "eye.slash", size: 20),
        ListItem(name: "Recently Deleted", image: "trash", size: 20),
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Divider()
                        .padding(.leading)

                    Section {
                        LazyVGrid(columns: columns){
                            ForEach(0..<4) { int in
                                let randomInt = Int.random(in: 1..<100)
                                NavigationLink {
                                } label: {
                                    VStack {
                                        Rectangle()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 5))
                                        HStack {
                                            Text("Album \(int+1)")
                                                .foregroundStyle(colorScheme == .light ? .black : .white)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("\(randomInt)")
                                                .foregroundStyle(colorScheme == .light ? .black : .white)
                                                .foregroundStyle(.secondary)
                                            Spacer()
                                        }
                                    }
                                }
                                .accessibilityLabel("Album \(int+1), \(randomInt) photos")
                            }
                        }
                        
                    } header: {
                        HStack {
                            Text("My Albums")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .accessibilityAddTraits([.isHeader])
                        .accessibilityLabel("My Albums")
                        
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.leading)
                        .padding(.top)
                    
                    Section {
                        List {
                            ForEach(listItems) { item in
                                NavigationLink {
                                    UnlockingView(obsVar: ObsVar())
                                } label: {
                                    HStack {
                                        Image(systemName: item.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: CGFloat(item.size))
                                        
                                        Text(item.name)
                                            .font(.title2)
                                            .padding(.leading, 10)
                                    }
                                    .foregroundStyle(.blue)
                                }
                            }
                        }
//                        .frame(minHeight: minRowHeight )
                        .frame(minHeight: minRowHeight * CGFloat(listItems.count))
                        .listStyle(PlainListStyle())
                    } header: {
                        HStack {
                            Text("Utilities")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.leading)
                            Spacer()
                        }
                        
                    }
                }
                .navigationTitle("Albums")
                
            }
        }
    }
}

#Preview {
    AlbumsView(obsVar: ObsVar())
}
