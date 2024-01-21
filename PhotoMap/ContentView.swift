//
//  ContentView.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var images: Images = Images(images: [ImageModel(name: "Apollo", image: Image("apollo10"))])
    @State private var imageItem: PhotosPickerItem?
    @State private var uploadedImage: Image?
    
    @State private var showingNameAlert = false
    @State private var imageName = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            PhotosPicker("Select image", selection: $imageItem, matching: .images)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            List(images.images) { image in
                HStack{
                    image.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(image.name)
                }
            }
//            uploadedImage?
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300, height: 300)
        }
        .onChange(of: imageItem) {
            Task {
                if let loaded = try? await imageItem?.loadTransferable(type: Image.self) {
                    uploadedImage = loaded
                    showingNameAlert.toggle()
                    
                } else {
                    print("Failed")
                }
            }
        }
        .alert("Please name the image", isPresented: $showingNameAlert){
           TextField("Enter the image name", text: $imageName)
            Button("OK") {
                print(imageName)
                if let uploadedImage = uploadedImage {
                    let newImage = ImageModel(name: imageName, image: uploadedImage)
                    images.images.append(newImage)
                    imageName = ""
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
