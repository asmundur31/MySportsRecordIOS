//
//  TrampetSkillItemView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 10.1.2023.
//

import SwiftUI
import AVKit

struct TrampetSkillItemView: View {
    var trampetSkill: TrampetSkill

    var body: some View {
        VStack {
            Divider()
            VideoPlayer(player: AVPlayer(url: URL(string: trampetSkill.videoUrl) ?? URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!))
                .frame(height: 250)
            Text(String(format: "Value: %.2f", trampetSkill.value))
        }
    }
}

struct TrampetSkillItemView_Previews: PreviewProvider {
    static var previews: some View {
        TrampetSkillItemView(trampetSkill: TrampetSkill(entryElement: TrampetSkill.EntryElement.no, saltos: TrampetSkill.Salto.two, twists: [1.0, 1.5], positions: [TrampetSkill.Position.straight, TrampetSkill.Position.straight]))
    }
}
