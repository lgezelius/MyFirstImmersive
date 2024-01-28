//
//  ContentView.swift
//  MyFirstImmersive
//
//  Created by Larry Gezelius on 1/27/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { value in
                var transform = value.entity.transform
                transform.translation += SIMD3(0.1, 0, -0.1)
                value.entity.move(
                    to: transform,
                    relativeTo: nil,
                    duration: 3,
                    timingFunction: .easeInOut
                )
            })
            
            Button("Open") {
                        Task {
                            await openImmersiveSpace(id: "ImmersiveSpace")
                        }
                    }

            VStack {
                Toggle("Change Size", isOn: $enlarge)
                    .toggleStyle(.button)
            }.padding().glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
