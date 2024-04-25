//
//  HorizontalFadeAwayCollectionViewCell.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/24/24.
//

import UIKit

class HorizontalFadeAwayCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalFadeAwayCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
