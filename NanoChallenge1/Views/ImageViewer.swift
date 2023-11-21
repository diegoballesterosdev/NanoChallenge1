//
//  ImageViewer.swift
//  NanoChallenge1
//
//  Created by Diego Ballesteros on 20/11/23.
//

import SwiftUI
import SwiftUIImageViewer

struct ImageViewer: View {
    let image: Image
    @Binding var isPresented: Bool

    var body: some View {
        SwiftUIImageViewer(image: image)
            .overlay(alignment: .topTrailing) {
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                }
                .buttonStyle(.bordered)
                .clipShape(Circle())
                .tint(.blue)
                .padding()
            }
    }
}

//#Preview {
//    ImageViewer()
//}
