//
//  ContentView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 15.12.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var navigationManager = SidebarNavigationManager()
    @State var showSidebar: Bool = false
    var sidebarWidth = 125
    var body: some View {
        ZStack {
            SideBarStack(sidebarWidth: CGFloat(sidebarWidth), showSidebar: $showSidebar) {
                SidebarView(navigationManager: navigationManager)
            } content: {
                switch navigationManager.viewType {
                case .main:
                    HomeView()
                        .padding()
                case .login:
                    LoginView()
                        .padding()
                case .signup:
                    SignUpView()
                        .padding()
                case .settings:
                    SettingsView()
                        .padding()
                }
            }
        }
        .overlay {
            Button {
                showSidebar.toggle()
            } label: {
                Label("", systemImage: "line.3.horizontal")
                    .font(.system(size: 36))
            }
            .position(x:showSidebar ? CGFloat(sidebarWidth+40) : 40, y: 10)
            .animation(.easeInOut(duration: 0.5), value: showSidebar)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
