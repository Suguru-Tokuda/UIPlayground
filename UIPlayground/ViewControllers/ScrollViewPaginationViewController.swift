//
//  ScrollViewPaginationViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/28/24.
//

import UIKit

class ScrollViewPaginationViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .orange
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.transfersVerticalScrollingToParent = false
        return scrollView
    }()
    let numberOfPages: Int = 5
    let padding: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .systemBackground
        scrollView.frame = view.bounds
        var xOffset: CGFloat = padding
        let viewWidth = view.frame.size.width - padding * 2
        let viewHeight = view.frame.size.height * 0.8
        
        for i in 0...numberOfPages {
            let view: UIView = UIView(frame: CGRect(x: xOffset, y: padding, width: viewWidth, height: viewHeight))
            view.backgroundColor = i % 2 == 0 ? .systemBlue : .systemRed
            scrollView.addSubview(view)
            xOffset = view.frame.origin.x + scrollView.frame.width
        }
        
        scrollView.contentSize = CGSize(width: xOffset - padding, height: viewHeight)
        view.addSubview(scrollView)
    }
}
