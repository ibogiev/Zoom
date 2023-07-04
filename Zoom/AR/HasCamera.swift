//
//  ZoomCoordinator.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import Foundation
import UIKit
import VideoToolbox

protocol HasCamera: ARCoordinator {

    var zoom: Float { get set }

    func setZoom(_ zoom: Float)

    func getPhoto() -> UIImage?
}

extension HasCamera {

    func setZoom(_ zoom: Float) {
        self.zoom = zoom
    }

    func getPhoto() -> UIImage?  {
        guard let frame = arView.session.currentFrame else {
            print("Cannot get fame of ARSession.")
            return nil
        }
        guard let image = UIImage(pixelBuffer: frame.capturedImage) else {
            print("Cannot create image using CVPixelBufferRef.")
            return nil
        }
        return image
    }
}


extension UIImage {
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        guard let cgImage = cgImage else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
}
