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
        
        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)
        
        let faceAnchor = try! Experience.loadScene()
        
        let mustache1 = faceAnchor.findEntity(named: "mustache1")
        mustache1?.isEnabled = false
        
        let mustache2 = faceAnchor.findEntity(named: "mustache2")
        mustache2?.isEnabled = false
        
        let mustache3 = faceAnchor.findEntity(named: "mustache3")
        mustache3?.isEnabled = false
        
        let mustache4 = faceAnchor.findEntity(named: "mustache4")
        mustache4?.isEnabled = false 
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(faceAnchor)
        
    }
    
    
    func toggleMustache1(){
        let mustache1 = self.arView.scene.findEntity(named: "mustache1")
        let mustache2 = self.arView.scene.findEntity(named: "mustache2")
        let mustache3 = self.arView.scene.findEntity(named: "mustache3")
        let mustache4 = self.arView.scene.findEntity(named: "mustache4")

        
        if mustache1?.isEnabled == true {
            mustache1?.isEnabled = false
        } else {
            mustache1?.isEnabled = true
            mustache2?.isEnabled = false
            mustache3?.isEnabled = false
            mustache4?.isEnabled = false
        }
    }
    
    func toggleMustache2(){
        let mustache1 = self.arView.scene.findEntity(named: "mustache1")
        let mustache2 = self.arView.scene.findEntity(named: "mustache2")
        let mustache3 = self.arView.scene.findEntity(named: "mustache3")
        let mustache4 = self.arView.scene.findEntity(named: "mustache4")

        
        if mustache2?.isEnabled == true {
            mustache2?.isEnabled = false
        } else {
            mustache2?.isEnabled = true
            mustache1?.isEnabled = false
            mustache3?.isEnabled = false
            mustache4?.isEnabled = false
        }
    }
    
    func toggleMustache3(){
        let mustache1 = self.arView.scene.findEntity(named: "mustache1")
        let mustache2 = self.arView.scene.findEntity(named: "mustache2")
        let mustache3 = self.arView.scene.findEntity(named: "mustache3")
        let mustache4 = self.arView.scene.findEntity(named: "mustache4")

        
        if mustache3?.isEnabled == true {
            mustache3?.isEnabled = false
        } else {
            mustache3?.isEnabled = true
            mustache1?.isEnabled = false
            mustache2?.isEnabled = false
            mustache4?.isEnabled = false
        }
    }
    
    func toggleMustache4(){
        let mustache1 = self.arView.scene.findEntity(named: "mustache1")
        let mustache2 = self.arView.scene.findEntity(named: "mustache2")
        let mustache3 = self.arView.scene.findEntity(named: "mustache3")
        let mustache4 = self.arView.scene.findEntity(named: "mustache4")

        
        if mustache4?.isEnabled == true {
            mustache4?.isEnabled = false
        } else {
            mustache4?.isEnabled = true
            mustache1?.isEnabled = false
            mustache2?.isEnabled = false
            mustache3?.isEnabled = false
        }
    }
}
