//
//  ContentView.swift
//  ObjectAndFaceAnchors
//
//  Created by Bo Zhong on 7/2/23.
//

import SwiftUI
import RealityKit
import ARKit


//reuseable view Modifiers for mustache views
struct MustacheModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 110, height: 110)
            .background(Color.clear)
            .clipShape(Capsule())
            .padding()
    }
}

extension View {
    func applyMustacheModifier() -> some View {
        self.modifier(MustacheModifier())
    }
}


struct ContentView : View {
    @StateObject var vm = ViewModel()
    
    //MARK: Recording Status
    @State private var isRecording = false
    @State var url: URL?
    @State var shareVideo: Bool = false
    
    var body: some View {
        VStack{
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
                .overlay(alignment: .bottom){
                    Button {
                        if isRecording {
                            Task {
                                
                                stopRecordingWithEdit { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                        return
                                    }
                                }
                                isRecording = false
                                
                            }
                        } else {
                            
                            startRecording { error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    return
                                }
                                
                                // Success
                                isRecording = true
                            }
                        }
                    } label: {
                        VStack{
                            Image(systemName: isRecording ? "stop.circle.fill" : "record.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55).bold()
                                .foregroundColor(isRecording ? .red : .white)
                            Text(isRecording ? "Stop Recording" : "Start Recording")
                                .font(.footnote).bold()
                                .foregroundColor(.white)
                        }
                        .padding()
                        .scaleEffect(isRecording ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1))
                    }
                    .padding()
                    
                }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    VStack{
                        Image("mustache1")
                            .resizable()
                            .scaledToFit()
                    }
                    .onTapGesture {
                        //                        debugging
                        //                        print("Mustache1 Tapped!")
                        vm.toggleMustache1()
                    }
                    
                    //custom viewModifier for recycable codes
                    .applyMustacheModifier()
                    
                    VStack{
                        Image("mustache2")
                            .resizable()
                            .scaledToFit()
                    }
                    .onTapGesture{
                        
                        //                        debugging
                        //                        print("Mustache2 tapped!")
                        vm.toggleMustache2()
                    }
                    .applyMustacheModifier()
                    
                    VStack{
                        Image("mustache3")
                            .resizable()
                            .scaledToFit()
                    }
                    .onTapGesture {
                        vm.toggleMustache3()
                    }
                    .applyMustacheModifier()
                    
                    VStack{
                        Image("mustache4")
                            .resizable()
                            .scaledToFit()
                    }
                    .onTapGesture {
                        vm.toggleMustache4()
                    }
                    .applyMustacheModifier()
                    
                }
                
            }
            .background(.clear)
            .frame(height: 100)
            .onAppear(perform: vm.configureARView)
        }
        .shareSheet(show: $shareVideo, items: [url])
    }
}
struct ARViewContainer: UIViewRepresentable {
    
    let vm : ViewModel
    
    func makeUIView(context: Context) -> ARView {
        return vm.arView
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
