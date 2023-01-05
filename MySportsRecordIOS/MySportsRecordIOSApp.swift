//
//  MySportsRecordIOSApp.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 15.12.2022.
//

import SwiftUI

@main
struct MySportsRecordIOSApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(RanklistsViewModel())
                .environmentObject(AuthenticationViewModel())
        }
    }
}
