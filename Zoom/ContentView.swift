//
//  ContentView.swift
//  Zoom
//
//  Created by Irakly Bogiev on 6/30/23.
//

import RealityKit
import SwiftUI

struct ContentView: View {

    @State private var image: UIImage?
    let coordinator: CameraCoordinator = .init(arView: .init(frame: .zero))

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            } else {
                ARCoordinatorRepresentable(coordinator: coordinator)
            }
        }
        .ignoresSafeArea(.all)
        .overlay(
            Button {
                if image == nil {
                    image = coordinator.getPhoto()
                } else {
                    image = nil
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Circle()
                        .foregroundColor(.gray)
                        .padding(2)
                }
            }
                .frame(width: 64, height: 64)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 24)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ARCoordinatorRepresentable: UIViewRepresentable {

    let coordinator: CameraCoordinator

    init(coordinator: CameraCoordinator) {
        self.coordinator = coordinator
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.addSubview(coordinator.arView)
        coordinator.arView.alpha = 0
        let mtImageView = coordinator.mtImageView
        view.addSubview(coordinator.mtImageView)
        mtImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                mtImageView.topAnchor.constraint(equalTo: view.topAnchor),
                mtImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
                mtImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
                mtImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        coordinator.mtImageView.frame = UIScreen.main.bounds

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}
