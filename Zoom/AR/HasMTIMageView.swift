//
//  HasMTIMageView.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import Combine
import UIKit
import MetalPetal
import RealityKit

protocol HasMTIImageView: ARCoordinator {


    static var context: MTIContext? { get }

    var mtImageView: MTIImageView { get }

    var mtImageViewCancellables: Set<AnyCancellable> { get set }

    func setupMTIImageView()
}

extension HasMTIImageView where Self: HasCamera {


    func setupMTIImageView() {
        mtImageView.resizingMode = .aspectFill
        arSessionDelegateHandler
            .didUpdateFramePublisher
            .map(\.capturedImage)
            .map { [unowned self] in
                let transformFilter = MTITransformFilter()
                let correctedZoom = CGFloat(min(max(1, zoom) ,3))
                transformFilter.transform = CATransform3DScale(
                    CATransform3DMakeRotation(
                        -.pi / 2, 0, 0, 1),
                    correctedZoom,
                    correctedZoom,
                    correctedZoom
                )
                transformFilter.inputImage = MTIImage(cvPixelBuffer: $0, alphaType: .alphaIsOne)
                let rotatedImage = transformFilter.outputImage

				return rotatedImage
            }
            .sink { [unowned self] in
                self.mtImageView.image = $0
                
            }
            .store(in: &mtImageViewCancellables)
    }
}
