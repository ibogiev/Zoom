//
//  ZoomApp.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import SwiftUI

@main
struct ZoomApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    FaceAnchorSystem.registerSystem()
                    FaceAnchorComponent.registerComponent()
                }
        }
    }
}
