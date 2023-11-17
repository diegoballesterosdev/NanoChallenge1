//
//  AlbumsGridView.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 17/11/23.
//

import SwiftUI

struct AlbumsGridView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    let rows = [GridItem(.adaptive(minimum: 170))]
    
    var body: some View {
        ScrollView(.horizontal) {
            Section {
                LazyHGrid(rows: rows, spacing: 20) {
                    ForEach(0..<9) { int in
                        let randomInt = Int.random(in: 1..<100)
                        NavigationLink {
                            Text("")
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
            }
            .frame(height: 400)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AlbumsGridView()
}
