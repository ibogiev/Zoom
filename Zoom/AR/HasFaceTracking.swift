//
//  HasFaceTracking.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import ARKit
import Combine
import Foundation
import RealityKit

protocol HasFaceTracking: ARCoordinator {

    var faceAnchor: AnchorEntity { get }
    var faceTrackingCancelables: Set<AnyCancellable> { get set }
    func setupFaceTracking()
}


extension HasFaceTracking where Self: HasCamera {

    func setupFaceTracking() {

        faceAnchor.components.set(FaceAnchorComponent(coordinator: self))
        faceAnchor.name = "faceAnchor"
        arView.scene.addAnchor(faceAnchor)
        arSessionDelegateHandler.didUpdateAnchorsPublisher
            .compactMap { anchors in
                anchors.compactMap { $0 as? ARFaceAnchor }
            }
            .compactMap { $0.last }
            .sink { [weak self] faceAnchor in
                guard let self else {
                    return
                }
                self.faceAnchor.transform = Transform(matrix: faceAnchor.transform)

            }
            .store(in: &faceTrackingCancelables)


    }
}
