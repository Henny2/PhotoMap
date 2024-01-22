//
//  ContentView.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//


/// Look into loading the image as DATA datatype instead of image
/// then need to add Swiftdata to the model / struct
///  need to make sure my example does not break. how do I get the image in assets as data input or can I just not intialize iJK I can initialize the array as empty



import SwiftUI
import PhotosUI

struct ContentView: View {
    
//    @State private var images: [ImageModel] = [ImageModel(name: "Apollo", image: Image("apollo10"))]
    @State private var images: [ImageModel] = [ImageModel]()
    @State private var imageItem: PhotosPickerItem?
    @State private var uploadedImage: Image?
    
    @State private var showingNameAlert = false
    @State private var imageName = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            PhotosPicker("Select image", selection: $imageItem, matching: .images)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            List(images) { image in
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
                    images.append(newImage)
                    imageName = ""
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
