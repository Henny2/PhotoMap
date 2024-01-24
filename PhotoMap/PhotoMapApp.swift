//
//  PhotoMapApp.swift
//  PhotoMap
//
//  Created by Henrieke Baunack on 1/21/24.
//

import SwiftUI
import SwiftData

@main
struct PhotoMapApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ImageModel.self)
    }
}
