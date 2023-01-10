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
            Color(red: 141/255, green: 223/255, blue: 144/255).ignoresSafeArea()
            
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
                }
            }
        }
        .overlay {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSidebar.toggle()
                }
            } label: {
                Label("", systemImage: "line.3.horizontal")
                    .font(.system(size: 36))
                    .foregroundColor(Color.black)
            }
            .position(x: showSidebar ? CGFloat(sidebarWidth+50) : 50, y:40)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(RanklistsViewModel())
            .environmentObject(AuthenticationViewModel())
            .environmentObject(UserViewModel())
    }
}
