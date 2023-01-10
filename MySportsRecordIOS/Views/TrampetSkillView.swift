//
//  TrampetSkillView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 9.1.2023.
//

import SwiftUI

struct TrampetSkillView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                if userViewModel.userTrampetSkills != [] {
                    Text("")
                        .frame(height: 150)
                    ForEach(userViewModel.userTrampetSkills, id: \.self) { trampetSkill in
                        TrampetSkillItemView(trampetSkill: trampetSkill)
                    }
                    Text("")
                        .frame(height: 150)
                } else {
                    Text("No posts yet")
                }
            }
        }
        .onAppear {
            userViewModel.getUserTrampetSkills()
        }
    }
}

struct TrampetSkillView_Previews: PreviewProvider {
    static var previews: some View {
        TrampetSkillView()
            .environmentObject(UserViewModel())
    }
}
