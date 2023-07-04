//
//  FaceAnchorSystem.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import Foundation
import RealityKit


final class FaceAnchorSystem: RealityKit.System {

    init(scene: Scene) {}

    private static let query = EntityQuery(where: .has(FaceAnchorComponent.self))
    
    func update(context: SceneUpdateContext) {
        print("count", context.scene.anchors.count)
        context.scene.performQuery(Self.query)
            .forEach { entity in
                guard let faceAnchorComponent = entity.components[FaceAnchorComponent.self] as? FaceAnchorComponent else {
                    assertionFailure("faceAnchorComponent should not be nil here.")
                    return
                }
                guard let coordinator = faceAnchorComponent.coordinator else {
                    return
                }
                let arView = coordinator.arView
                coordinator.setZoom(abs(length(arView.cameraTransform.translation - entity.position)) * 4 )
            }
    }
}


struct FaceAnchorComponent: Component {

    weak var coordinator: HasCamera?
}
