//
//  TickTokCloneCollectionViewCell.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import UIKit
import AVFoundation

class TikTokCloneCollectionViewCell: UICollectionViewCell {
    static let identifier = "TickTokCloneCollectionViewCell"
    // Subviews
    var player: AVPlayer?
    private var model: VideoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
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
              let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else { return }

        player = AVPlayer(url: URL(filePath: path))
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
}
