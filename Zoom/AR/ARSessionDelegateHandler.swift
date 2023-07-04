//
//  ARSessionDelegateHandler.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import ARKit
import Combine


class ARSessionDelegateHandler: NSObject, ARSessionDelegate {

    let didUpdateFramePublisher = PassthroughSubject<ARFrame, Never>()

    let didAddAnchorsPublisher = PassthroughSubject<[ARAnchor], Never>()

    let didUpdateAnchorsPublisher = PassthroughSubject<[ARAnchor], Never>()

    let didRemoveAnchorsPublisher = PassthroughSubject<[ARAnchor], Never>()


    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        didUpdateFramePublisher.send(frame)
    }

    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        didAddAnchorsPublisher.send(anchors)
    }


    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        didUpdateAnchorsPublisher.send(anchors)
    }


    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        didRemoveAnchorsPublisher.send(anchors)
    }

    
}
