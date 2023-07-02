//
//  ContentView.swift
//  ObjectAndFaceAnchors
//
//  Created by Bo Zhong on 7/2/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack{
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal){
                HStack {
                    VStack{
                        Image("mustache1")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 110, height: 110)
                    .onTapGesture {
                        vm.toggleMustache1()
                    }
                    .background(Color.clear)
                    .clipShape(Capsule())
                    .padding()
                }
                
            }
            .background(.clear)
            .frame(height: 100)
            .onAppear(perform: vm.configureARView)
        }
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
