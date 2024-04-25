//
//  TestViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/24/24.
//

import UIKit

class TestViewController: UIViewController {
    let contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .green
        return contentView
    }()

    let leftGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1,0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.5)
        return gradientLayer
    }()

    let rightGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1,0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.5)
        return gradientLayer
    }()

    let maskLayer: CALayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 100),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        leftGradientLayer.frame = contentView.bounds
//        maskLayer.addSublayer(leftGradientLayer)
//        maskLayer.addSublayer(rightGradientLayer)
        maskLayer.frame = contentView.bounds
        contentView.layer.mask = maskLayer
    }
}
