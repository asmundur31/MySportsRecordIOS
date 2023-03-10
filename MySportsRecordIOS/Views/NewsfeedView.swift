//
//  NewsfeedView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct NewsfeedView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Most recent uploads")
                    .font(.title)
                if userViewModel.recentSkills != [] {
                    ForEach(userViewModel.recentSkills, id: \.self) { skill in
                        SkillItemView(skill: skill)
                            .padding(.vertical)
                    }
                } else {
                    Text("")
                        .frame(height: 200)
                    Text("No posts yet")
                }
                
            }
        }
        .onAppear {
            userViewModel.getRecentSkills()
        }
    }
}

struct NewsfeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsfeedView()
            .environmentObject(UserViewModel())
    }
}
