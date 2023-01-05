//
//  SidebarButtonView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct SidebarButtonView: View {
    @Binding var showSidebar: Bool

    var body: some View {
        Image(systemName: "line.3.horizontal")
            .onTapGesture {
                showSidebar.toggle()
            }
    }
}
