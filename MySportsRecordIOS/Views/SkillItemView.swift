//
//  SkillItemView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 10.1.2023.
//

import SwiftUI
import AVKit

struct SkillItemView: View {
    var skill: SkillDTO

    var body: some View {
        VStack {
            Divider()
            HStack {
                Text("User: \(skill.user.username)")
                Spacer()
            }
            VideoPlayer(player: AVPlayer(url: URL(string: skill.video_url) ?? URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!))
                .frame(height: 250)
            HStack {
                Text(String(format: "Value: %.2f", skill.value))
                Spacer()
                Text("Apparatus: \(skill.apparatus)")
            }
        }
    }
}

struct SkillItemView_Previews: PreviewProvider {
    static var previews: some View {
        SkillItemView(skill: SkillDTO(skill: "{\"table\":\"No\",\"saltos\":3,\"twists\":[0,0,0.5],\"positions\":[\"piked\",\"piked\",\"piked\"]}", video_url: "https://firebasestorage.googleapis.com:443/v0/b/mysportsrecordios.appspot.com/o/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsInVzZXJuYW1lIjoiw4FzbXVuZHVyIMOTc2thciIsImVtYWlsIjoiQXNtdW5kdXIzMUBnbWFpbC5jb20iLCJwYXNzd29yZCI6IiQyYiQxMCRFVGhkb1ZncTNUZ0UvU2ZVVjlWMFZlbmlEMDNlYW53aDd3b1pSSGJiZnRqN0JYL2ltdkhjdSIsIm5hdGlvbmFsaXR5IjoiSWNlbGFuZCIsImNsdWIiOiJCcm9tbWFneW1uYXN0ZXJuYSIsImJpcnRoZGF5IjoiMTk5OC0xMC0zMSIsImdlbmRlciI6Ik1hbGUiLCJzY29yZSI6MCwiaWF0IjoxNjczMzUzMTAzLCJleHAiOjE2NzMzNTQwMDN9.0YlkeWDNycRD6Qa0kgSjHrd9xMtToEwLFYs1jOMQVJM%2FVideos%2F1673353140.mp4?alt=media&token=14732422-70e0-4660-a538-86bbd4df4dd8", apparatus: "trampet", value: 1.7, user: SkillDTO.User(username: "Ásmundur", email: "asmundur31@gmail.com", nationality: "Iceland", club: "Brommagymnasterna", birthday: "1998-10-31", gender: "Male", score: 3.5)))
    }
}
