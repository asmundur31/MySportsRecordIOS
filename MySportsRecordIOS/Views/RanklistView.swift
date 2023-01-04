//
//  RanklistView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct RanklistView: View {
    @EnvironmentObject var ranklistViewModel: RanklistsViewModel

    var body: some View {
        VStack {
            Text("Ranklist - Trampet")
                .font(.title3)
            ScrollView {
                LazyVStack {
                    ForEach(ranklistViewModel.topUsers.users.indices, id: \.self) { i in
                        UserItemView(user: ranklistViewModel.topUsers.users[i], place: i+1)
                    }
                }
            }
            .onAppear {
                ranklistViewModel.getTopUsers()
            }
        }
        .padding()
    }
}

struct RanklistView_Previews: PreviewProvider {
    static var previews: some View {
        RanklistView()
            .environmentObject(RanklistsViewModel())
    }
}
