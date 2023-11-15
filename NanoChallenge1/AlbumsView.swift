//
//  AlbumsView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 15/11/23.
//

import SwiftUI

struct AlbumsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    @ObservedObject var obsVar: ObsVar
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    Divider()
                        .padding(.leading)
                    
                    Section {
                        LazyVGrid(columns: columns){
                            ForEach(0..<4) { int in
                                NavigationLink {
                                } label: {
                                    VStack {
                                        Rectangle()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 5))
                                        HStack {
                                            Text("Album")
                                                .foregroundStyle(colorScheme == .light ? .black : .white)
                                            //                                                    .fore
                                            Spacer()
                                        }
                                        HStack {
                                            Text("100")
                                                .foregroundStyle(colorScheme == .light ? .black : .white)
                                                .foregroundStyle(.secondary)
                                            //                                                    .font(.caption)
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                }
                            }
                        }
                        
                    } header: {
                        HStack {
                            Text("My Albums")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.leading)
                        .padding(.top)
                    
                    Section {
                        List {
                            NavigationLink {
                                UnlockingView(obsVar: ObsVar())
                            } label: {
                                HStack {
                                    Image(systemName: "eye.slash")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    Text("Hidden")
                                        .font(.title2)
                                        .padding(.leading, 10)
                                }
                                .foregroundStyle(.blue)
                            }
                            
                            
                            NavigationLink {
                                UnlockingView(obsVar: ObsVar())
                            } label: {
                                HStack {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                    Text("Hidden")
                                        .font(.title2)
                                        .padding(.leading, 13)
                                }
                                .foregroundStyle(.blue)
                            }
                            
                        }
                        .frame(minHeight: minRowHeight * 2)
                        .listStyle(PlainListStyle())
                    } header: {
                        HStack {
                            Text("Utilities")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    
                }
                .navigationTitle("Albums")
                .onAppear() {
                    print("disappear")
                    obsVar.unlocked = false
                }
            }
        }
        
    }
}

#Preview {
    AlbumsView(obsVar: ObsVar())
}
