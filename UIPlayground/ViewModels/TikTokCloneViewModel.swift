//
//  TikTokCloneViewModel.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import Foundation

class TikTokCloneViewModel {
    var data: [VideoModel] = []
    
    init() {
        var data: [VideoModel] = []
        for _ in 0..<5 {
            let model = VideoModel(caption: "This is a cool car", userName: "@suguru", audioTrackName: "iOS Academy Video Song", videoFileName: "SnapTik_App_7330727297772784939-HD", videoFileFormat: "mp4")
            data.append(model)
        }
        self.data = data
    }
}
