//
//  SoundOnApp.swift
//  SoundOn
//
//  Created by Francois Everhard Air on 4/29/25.
//

import SwiftUI
//import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
        return true
    }
}



@main
struct SoundOnApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            View_Template()
            
        }
    }
}

