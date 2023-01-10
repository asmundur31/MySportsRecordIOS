//
//  TrampetFormView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 9.1.2023.
//

import SwiftUI
import PhotosUI
import AVKit

struct TrampetFormView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selectedVideo: [PhotosPickerItem] = []
    @State var data: Data?

    var body: some View {
        NavigationView {
            Form {
                entryElementSection
                numberOfSaltosSection
                positionsAndTwistsSection
                videoSection
                
                Button {
                    userViewModel.addTrampetSkill(videoData: data!)
                } label: {
                    Text("Submit")
                }
            }
        }
    }
}

struct TrampetFormView_Previews: PreviewProvider {
    static var previews: some View {
        TrampetFormView()
            .environmentObject(UserViewModel())
    }
}

private extension TrampetFormView {
    var entryElementSection: some View {
        Section {
            Picker("Entry element", selection: $userViewModel.newTrampetSkill.entryElement) {
                ForEach(TrampetSkill.EntryElement.allCases, id: \.self) { element in
                    Text(element.rawValue)
                }
            }
        } footer: {
            Text("Please choose the entry element")
        }
    }
    
    var numberOfSaltosSection: some View {
        Section {
            Picker("Number of saltos", selection: $userViewModel.newTrampetSkill.saltos) {
                ForEach(TrampetSkill.Salto.allCases, id: \.self) { element in
                    Text("\(element.rawValue)")
                }
            }
            .onChange(of: userViewModel.newTrampetSkill.saltos) { newValue in
                userViewModel.newTrampetSkill.setSaltos(newValue)
            }
        } footer: {
            Text("Please choose the number of saltos")
        }
    }
    
    var positionsAndTwistsSection: some View {
        Section {
            if userViewModel.newTrampetSkill.saltos.rawValue > 0 {
                ForEach(0..<userViewModel.newTrampetSkill.saltos.rawValue, id: \.self) { index in
                    Picker("Position in salto \(index+1)", selection: $userViewModel.newTrampetSkill.positions[index]) {
                        ForEach(TrampetSkill.Position.allCases, id: \.self) { pos in
                            Text(pos.rawValue)
                        }
                    }
                }
                ForEach(0..<userViewModel.newTrampetSkill.saltos.rawValue, id: \.self) { index in
                    Picker("Twists in salto \(index+1)", selection: $userViewModel.newTrampetSkill.twists[index]) {
                        ForEach(Array(stride(from: 0, to: 6, by: 0.5)), id: \.self) { twist in
                            Text(String(format: "%.1f", twist))
                        }
                    }
                }
            } else {
                Text("No saltos are selected")
            }
        } footer: {
            Text("Choose the position and twists for each salto performed")
        }
    }
    
    var videoSection: some View {
        Section {
            PhotosPicker(selection: $selectedVideo, maxSelectionCount: 1, matching: .videos) {
                Text("Select video")
            }
            .onChange(of: selectedVideo) { newValue in
                guard let video = selectedVideo.first else {
                    return
                }
                video.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.data = data
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } footer: {
            Text("Select a video of the skill performed")
        }
    }
}
