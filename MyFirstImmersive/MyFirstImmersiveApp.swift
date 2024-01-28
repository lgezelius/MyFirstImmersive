//
//  MyFirstImmersiveApp.swift
//  MyFirstImmersive
//
//  Created by Larry Gezelius on 1/27/24.
//

import SwiftUI

@main
struct MyFirstImmersiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
