//
//  TickTokCloneCollectionViewCell.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import UIKit
import AVFoundation

class VideoReelsCollectionView: UICollectionViewCell {
    static let identifier = "TickTokCloneCollectionViewCell"
    // Subviews
    var player: AVPlayer?
    private var model: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
    }

    private func configureVideo() {
        // configure
        guard let model,
              let url = URL(string: model.videoURL) else { return }

        player = AVPlayer(url: url)
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
}
