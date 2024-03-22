//
//  TikTokCloneViewModel.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import Foundation

class VideoReelViewModel {
    var videos: [VideoModel] = []
    var localDataManager: LocalDataManaging
    var videoLoaded: (() -> ())?
    let jsonFileName = "videoList"
    
    init(localDataManager: LocalDataManaging = LocalDataManager()) {
        self.localDataManager = localDataManager
    }

    func loadVideos() {
        do {
            let videos = try localDataManager.getData(fileName: jsonFileName, extensionStr: "json", type: [VideoModel].self)
            self.videos = videos
            videoLoaded?()
        } catch {
            print(error.localizedDescription)
        }
    }
}
