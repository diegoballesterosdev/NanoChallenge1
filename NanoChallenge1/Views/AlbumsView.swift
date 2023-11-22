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
                        AlbumsGridView()
                            .onAppear() {
                                obsVar.unlocked = false
                            }
                        
                    } header: {
                        HStack {
                            Text("My Albums")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.leading)
                            Spacer()
                        }
                        .accessibilityAddTraits([.isHeader])
                        .accessibilityLabel("My Albums")
                        
                    }
                    
                    Divider()
                        .padding(.leading)
                        .padding(.top)
                    
                    Section {
                        List {
                            ForEach(listItems) { item in
                                NavigationLink {
                                    UnlockingView(obsVar: ObsVar(), title: item.name)
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
