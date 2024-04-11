//
//  TopBottomGradientViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/11/24.
//

import UIKit

class TopBottomGradientViewController: TopNavBarLessViewController {
    private var gradientHeightMultiplier = 0.2185338866
    private static let gradientColors = [UIColor.black.withAlphaComponent(0.5).cgColor,
                                         UIColor.black.withAlphaComponent(0.0).cgColor]
    private let topGradient = CAGradientLayer(colors: gradientColors)
    private let bottomGradient = CAGradientLayer(colors: gradientColors)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotifications()
    }

    private func setupUI() {
        view.backgroundColor = .white
        configureGradients()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layer.addSublayer(topGradient)
        view.layer.addSublayer(bottomGradient)
    }

    private func configureGradients() {
        let gradientHeight = view.bounds.height * gradientHeightMultiplier
        topGradient.configure(frame: CGRect(x: 0, 
                                            y: 0,
                                            width: view.bounds.width,
                                            height: gradientHeight),
                              startPoint: CGPoint(x: 0.5, y: 0),
                              endPoint: CGPoint(x: 0.5, y: 1))
        bottomGradient.configure(frame: CGRect(x: 0,
                                               y: view.bounds.height - gradientHeight,
                                               width: view.bounds.width,
                                               height: gradientHeight),
                                 startPoint: CGPoint(x: 0.5, y: 1),
                                 endPoint: CGPoint(x: 0.5, y: 0))
    }
}

extension TopBottomGradientViewController {
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(onOrientationChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }

    @objc private func onOrientationChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { @MainActor [weak self] in
            guard let self else { return }
            self.configureGradients()
        }
    }
}
