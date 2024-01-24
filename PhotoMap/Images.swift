//
//  Images.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class ImageModel: Identifiable {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var imageData: Data?
    var image: Image {
        if let imageData = self.imageData {
            if let inputImage = UIImage(data: imageData) {
                return Image(uiImage: inputImage)
            }
        }
        return Image("error")
    }
    
    init(name: String, imageData: Data) {
        self.id = UUID()
        self.name = name
        self.imageData = imageData
    }
}
