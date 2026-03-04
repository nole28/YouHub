//
//  UploadView.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

enum PrivacyOption: String, CaseIterable {
    case `public` = "Public"
    case friends = "Friends"
    case `private` = "Private"
}

struct UploadView: View {
    //Enviroment
    @EnvironmentObject var store: VideoStore
    @EnvironmentObject var session: UserSession
    
    //State
    @State private var videoTitle = ""
    @State private var videoDescription = ""
    @State private var isUploading = false
    @State private var privacy: PrivacyOption = .public
    @State private var showAlert = false


    var body: some View {
        Form {
            
            //MARK: - Video info
            Section("Video") {
                
                TextField("Title", text: $videoTitle)
                TextField("Description",
                          text: $videoDescription,
                          axis: .vertical
                )
            }

            //MARK: - Privacy
            Section("Privacy") {
                Picker("Who can watch", selection: $privacy) {
                    ForEach(PrivacyOption.allCases, id: \.self) { Text($0.rawValue) }
                }
                .pickerStyle(.segmented)
            }

            Section {
                Button(action: uploadVideo) {
                    if isUploading {
                        ProgressView("Uploading…").frame(maxWidth: .infinity)
                    } else {
                        Text("Upload Video").frame(maxWidth: .infinity)
                    }
                }
                .disabled(videoTitle.isEmpty || isUploading)
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .navigationTitle("Upload")
        .alert("Upload Complete", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text("Video uploaded with \(privacy.rawValue) privacy.")
        }
    }

    private func uploadVideo() {
        isUploading = true
        
        //Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            let newVideo = Video(channelID: session.user.id,
                                 title: videoTitle,
                                 thumbnailURL: "",
                                 videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                 description: videoDescription,
                                 duration: 120
            
            )

            store.addVideo(newVideo)
            
            //UI Reset
            isUploading = false
            showAlert = true
            videoTitle = ""
            videoDescription = ""
            privacy = .public
        }
    }
}
