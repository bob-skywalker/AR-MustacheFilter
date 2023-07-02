//
//  ViewModel.swift
//  ObjectAndFaceAnchors
//
//  Created by Bo Zhong on 7/2/23.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

class ViewModel: ObservableObject{
    @Published var arView: ARView = ARView(frame: .zero)
    
    func configureARView() {
           if !ARFaceTrackingConfiguration.isSupported {
               print("Your device does not support Face Anchor!")
           } else {
               
               let configuration = ARFaceTrackingConfiguration()
               arView.session.run(configuration)
               
               let faceAnchor = try! Experience.loadScene()
               
               let mustache1 = faceAnchor.findEntity(named: "mustache1")
               mustache1?.isEnabled = false
               
               let mustache2 = faceAnchor.findEntity(named: "mustache2")
               mustache2?.isEnabled = false

               // Add the box anchor to the scene
               arView.scene.anchors.append(faceAnchor)
           }
    }
    
    
    func toggleMustache1(){
        let mustache1 = self.arView.scene.findEntity(named: "mustache1")
        if mustache1?.isEnabled == true {
            mustache1?.isEnabled = false
        } else {
            mustache1?.isEnabled = true
        }
    }
}
