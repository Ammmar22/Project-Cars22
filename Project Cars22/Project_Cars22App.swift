//
//  Project_Cars22App.swift
//  Project Cars22
//
//  Created by Abderrahmen on 02/11/2024.
//

import SwiftUI
import Firebase

@main
struct Project_Cars22App: App {
    @State private var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "HasLaunchedBefore") == false

    init() {
           FirebaseApp.configure()
       }
    
    var body: some Scene {
        WindowGroup {
                if  isFirstLaunch {
                    LanchScreen(onFinish: {
                        // Update UserDefaults to indicate the app has launched
                        UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
                        isFirstLaunch = false
                    })
                } else {
                    ContentView() // Your main app view
                }
            }
        }
}
