//
//  CameraCoordinator.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import Combine
import MetalPetal
import RealityKit

final class CameraCoordinator: ARCoordinator, HasCamera, HasFaceTracking, HasMTIImageView {

    var zoom: Float = 1
    static let context: MTIContext? = try? MTIContext(device: MTLCreateSystemDefaultDevice()!)

    var mtImageView: MTIImageView = MTIImageView()

    let faceAnchor = AnchorEntity()

    var faceTrackingCancelables: Set<AnyCancellable> = []

    var mtImageViewCancellables: Set<AnyCancellable> = []


    override init(arView: ARView) {
        super.init(arView: arView)
        setupFaceTracking()
        setupMTIImageView()
    }
}
