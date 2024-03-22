//
//  VideoModel.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import Foundation

struct VideoModel: Decodable {
    let caption: String
    let userName: String
    let audioTrackName: String
    let videoURL: String
}
