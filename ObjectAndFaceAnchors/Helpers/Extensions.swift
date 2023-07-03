//
//  Extensions.swift
//  ObjectAndFaceAnchors
//
//  Created by Bo Zhong on 7/2/23.
//

import SwiftUI
import ReplayKit

//MARK: APP Recording Extensions

class ReplayDelegate: NSObject, RPPreviewViewControllerDelegate{
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        previewController.dismiss(animated: true)
    }
}

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
    
    func rootController() -> UIViewController? {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return scene.windows.first?.rootViewController
        }
        return nil
    }
    
    func stopRecordingWithEdit(completion: @escaping (Error?) -> () ){
            
            let recorder = RPScreenRecorder.shared()
            let delegate = ReplayDelegate()
            
            recorder.stopRecording { controller, err in
                if let controller = controller{
                    controller.modalPresentationStyle = .fullScreen
                    controller.previewControllerDelegate = delegate
                    DispatchQueue.main.async {
                        if let root = self.rootController(){
                            root.present(controller, animated: true)
                            completion(nil)
                        } else {
                            print("Could not find root view controller.")
                            completion(err)
                        }
                    }
                } else {
                    print("Error stopping recording: \(err?.localizedDescription ?? "Unknown error")")
                    completion(err)
                }
            }
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
