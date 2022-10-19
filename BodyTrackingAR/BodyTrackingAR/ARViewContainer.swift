//
//  ARViewContainer.swift
//  BodyTrackingAR
//
//  Created by Andrew Ushakov on 7/28/22.
//

import SwiftUI
import ARKit
import RealityKit

private var bodySkeleton: BodySkeleton?
private var bodySkeletonAnchor = AnchorEntity()

struct ARViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView

    func updateUIView(_ uiView: ARView, context: Context) {

    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)

        arView.setUpForBodyTracking()
        arView.scene.addAnchor(bodySkeletonAnchor)

        return arView
    }
}

extension ARView: ARSessionDelegate {
    func setUpForBodyTracking() {
        let configuration = ARBodyTrackingConfiguration()
        self.session.run(configuration)

        self.session.delegate = self
    }

    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let bodyAnchor = anchor as? ARBodyAnchor {
                if let bodySkeleton = bodySkeleton {
                    // BodySkeleton already exists, update all joints and bones
                    bodySkeleton.update(with: bodyAnchor)
                } else {
                    // BodySkeleton doesn't exist. It means that the body has been detected for the first time.
                    bodySkeleton = BodySkeleton(for: bodyAnchor)
                    bodySkeletonAnchor.addChild(bodySkeleton!)
                }
            }
        }
    }
}
