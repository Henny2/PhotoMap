//
//  ContentView.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//


/// Look into loading the image as DATA datatype instead of image
/// then need to add Swiftdata to the model / struct
///  need to make sure my example does not break. how do I get the image in assets as data input or can I just not intialize iJK I can initialize the array as empty

/// Link on UIImage, Image, CIImage, CGImage: https://www.hackingwithswift.com/books/ios-swiftui/integrating-core-image-with-swiftui
///https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-photospicker

import SwiftUI
import PhotosUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @Query(sort: \ImageModel.name) var images: [ImageModel]
    @State private var imageItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var uploadedImage: Image?
    
    @State private var showingNameAlert = false
    @State private var imageName = ""
    
    @Environment(\.dismiss) var dismiss
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker("Select image", selection: $imageItem, matching: .images)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                List(images) { image in
                    NavigationLink { 
                        ImageDetailView(image: image)
                    }
                label: {
                        HStack{
                            image.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text(image.name)
                        }
                    }
                }
//                uploadedImage?.resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
                
            }
            .onChange(of: imageItem) {
                Task {
                    if let unwrappedImageData = try? await imageItem?.loadTransferable(type: Data.self) {
                        imageData = unwrappedImageData
                        guard let inputImage = UIImage(data: unwrappedImageData) else { return }
                        uploadedImage = Image(uiImage: inputImage)
                        print(locationFetcher.lastKnownLocation!)
                        showingNameAlert.toggle()
                    } else {
                        print("Failed")
                    }
                }
            }
        }
        .alert("Please name the image", isPresented: $showingNameAlert){
           TextField("Enter the image name", text: $imageName)
            Button("OK") {
                if let unwrappedImageData = imageData {
                    let newImage = ImageModel(name: imageName, imageData: unwrappedImageData)
                    modelContext.insert(newImage)
                    imageName = ""
                } else {
                    print("could not unwrap image data")
                }
            }
        }
        .onAppear(){
            locationFetcher.start()
        }
    }
}

#Preview {
    ContentView()
}
