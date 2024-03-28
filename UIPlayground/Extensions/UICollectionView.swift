//
//  UICollectionView.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/27/24.
//

import UIKit

extension UICollectionView {
    func findRectInView() -> CGRect {
        CGRect(origin: self.contentOffset, size: self.bounds.size)
    }

    func findVisiblePoint() -> CGPoint {
        let visibleRect = findRectInView()
        return CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    }
}
