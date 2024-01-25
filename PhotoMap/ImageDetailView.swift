//
//  ImageDetailView.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/23/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: ImageModel
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text(image.name).font(.title)
            image.image
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Button("Delete image"){
                deleteImage(image: image)
            }
        }
    }
    
    func deleteImage(image:ImageModel) {
        print("delete image \(image.name)")
        modelContext.delete(image)
        dismiss()
    }
}

#Preview {
    ImageDetailView(image: ImageModel(name: "Test", imageData: Data()))
}
