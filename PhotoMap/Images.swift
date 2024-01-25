//
//  Images.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//

import Foundation
import SwiftUI
import SwiftData
import CoreLocation

@Model
class ImageModel: Identifiable {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var imageData: Data?
    var latitude: Double
    var longitude: Double
    var image: Image {
        if let imageData = self.imageData {
            if let inputImage = UIImage(data: imageData) {
                return Image(uiImage: inputImage)
            }
        }
        return Image("error")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    init(name: String, imageData: Data, latitude: Double, longitude: Double ) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.imageData = imageData
    }
}
