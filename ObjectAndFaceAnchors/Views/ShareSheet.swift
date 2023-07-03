//
//  ShareSheet.swift
//  ObjectAndFaceAnchors
//
//  Created by Bo Zhong on 7/2/23.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let view = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
