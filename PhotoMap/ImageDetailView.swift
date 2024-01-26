//
//  ImageDetailView.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/23/24.
//

import SwiftUI
import MapKit

struct ImageDetailView: View {
    let image: ImageModel
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text(image.name)
                .font(.title)
                .padding(.top)
            image.image
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Map() {
                Marker("", coordinate: CLLocationCoordinate2D(latitude: image.unwrappedLatitue, longitude: image.unwrappedLongitude))
            }
                .mapStyle(.hybrid)
                .frame(width: 250, height: 250)
                .padding()
                
            Button("Delete image"){
                deleteImage(image: image)
            }.padding()
           
            
        }
    }
    
    func deleteImage(image:ImageModel) {
        print("delete image \(image.name)")
        modelContext.delete(image)
        dismiss()
    }
}

#Preview {
    ImageDetailView(image: ImageModel(name: "Test", imageData: Data(), latitude: 22.3, longitude: 23.4))
}
