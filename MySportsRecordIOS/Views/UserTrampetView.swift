//
//  UserTrampetView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 9.1.2023.
//

import SwiftUI

struct UserTrampetView: View {
    @State var showSkillForm: Bool = false

    var body: some View {
        NavigationView {
            LazyVStack {
                TrampetSkillView()
                    .frame(height: 500)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showSkillForm.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showSkillForm) {
                TrampetFormView()
            }
        }
    }
}

struct UserTrampetView_Previews: PreviewProvider {
    static var previews: some View {
        UserTrampetView()
    }
}
