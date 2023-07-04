//
//  ARCoordinator.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import Foundation
import ARKit
import RealityKit

class ARCoordinator {

    let arView: ARView

    let arSessionDelegateHandler = ARSessionDelegateHandler()

    init(arView: ARView) {
        self.arView = arView
        arView.session.delegate = arSessionDelegateHandler
        let configuration = ARWorldTrackingConfiguration()
        configuration.userFaceTrackingEnabled = true
        arView.session.run(configuration)
    }
}


