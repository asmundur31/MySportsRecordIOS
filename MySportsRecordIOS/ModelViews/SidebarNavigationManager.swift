//
//  SidebarNavigationManager.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

// Idea taken from https://stackoverflow.com/questions/66909159/how-to-navigate-to-different-views-in-a-side-bar-in-swift

import Foundation

class SidebarNavigationManager : ObservableObject {
    @Published var viewType : ViewTypes = .main
}

enum ViewTypes {
    case main
    case login
    case signup
    case settings
}
