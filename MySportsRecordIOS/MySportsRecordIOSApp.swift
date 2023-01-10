//
//  MySportsRecordIOSApp.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 15.12.2022.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MySportsRecordIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(RanklistsViewModel())
                .environmentObject(AuthenticationViewModel())
                .environmentObject(UserViewModel())
        }
    }
}
