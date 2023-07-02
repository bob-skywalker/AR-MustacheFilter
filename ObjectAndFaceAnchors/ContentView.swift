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
                    .onTapGesture {
                        print("Mustache1 Tapped!")
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
                        print("Mustache2 tapped!")
                        vm.toggleMustache2()
                    }
                    .applyMustacheModifier()
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
