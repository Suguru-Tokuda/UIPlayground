//
//  VideoReelsGradientView.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/6/24.
//

import UIKit

class VideoReelsGradientView: UIView {
    var colors: [CGColor] = []
    var locations: [NSNumber]?
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    
    init(frame: CGRect, colors: [CGColor], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, locations: [NSNumber]? = nil) {
        super.init(frame: frame)
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations

        if let startPoint,
           let endPoint {
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }

        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
