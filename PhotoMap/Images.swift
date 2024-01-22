//
//  Images.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//

import Foundation
import SwiftUI
import SwiftData


class ImageModel: Identifiable {
    var id: UUID
    var name: String
//    @Attribute(.externalStorage) var image: Data?
    var image: Image
    
    init(name: String, image: Image) {
        self.id = UUID()
        self.name = name
        self.image = image
    }
}
