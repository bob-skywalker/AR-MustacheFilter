//
//  Extensions.swift
//  ObjectAndFaceAnchors
//
//  Created by Bo Zhong on 7/2/23.
//

import SwiftUI
import ReplayKit

//MARK: APP Recording Extensions

extension View{
    //MARK: Start Recording
    
    func startRecording(enabledMicrophone: Bool = true, completion: @escaping (Error?) -> ()){
        
        let recorder = RPScreenRecorder.shared()
         
        //Microphone Option
        recorder.isMicrophoneEnabled = true
        
        recorder.startRecording(handler: completion)
    }
    
    //MARK: Stop Recording
    //It will return the recorded video URL
    func stopRecording() async throws -> URL {
        // File will be stored in a temporary Directory
        let name = UUID().uuidString + ".mov"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        
        let recorder = RPScreenRecorder.shared()
        
        try await recorder.stopRecording(withOutput: url)
        
        return url
    }
    
    func cancelRecording() {
        let recorder = RPScreenRecorder.shared()
        recorder.discardRecording {}
    }
    
    func shareSheet(show: Binding<Bool>, items: [Any?]) -> some View {
        return self
            .sheet(isPresented: show) {
                
            } content: {
                let items = items.compactMap { item -> Any? in
                    return item
                }
                
                if !items.isEmpty {
                    ShareSheet(items: items)
                }
            }

    }
}
