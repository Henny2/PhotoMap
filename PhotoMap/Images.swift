//
//  Images.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//

import Foundation
import SwiftUI

struct Images {
    var images: [ImageModel]
}

struct ImageModel: Identifiable {
    var id = UUID()
    var name: String
    var image: Image
}
