//
//  CAGradientLayer.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/11/24.
//

import UIKit

extension CAGradientLayer {
    convenience init(colors: [CGColor]) {
        self.init()
        self.colors = colors
    }

    func configure(frame: CGRect, startPoint: CGPoint, endPoint: CGPoint) {
        self.frame = frame
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}
