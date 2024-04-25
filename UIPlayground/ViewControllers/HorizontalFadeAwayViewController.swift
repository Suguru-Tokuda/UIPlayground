//
//  HorizontalFadeAwayViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 4/24/24.
//

import UIKit

class HorizontalFadeAwayViewController: UIViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HorizontalFadeAwayCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalFadeAwayCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.black.cgColor,
                                UIColor.black.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.1, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        gradientLayer.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.mask = gradientLayer
        processScrollViewDidScroll(collectionView.contentOffset)
    }

    func setupUI() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension HorizontalFadeAwayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalFadeAwayCollectionViewCell.identifier, for: indexPath) as? HorizontalFadeAwayCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .systemBlue
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
}

extension HorizontalFadeAwayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension HorizontalFadeAwayViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        processScrollViewDidScroll(scrollView.contentOffset)
    }

    func processScrollViewDidScroll(_ contentOffset: CGPoint) {
        let indexPaths = collectionView.indexPathsForVisibleItems
        var leftEdgePartiallyVisible = false
        var rightEdgePartiallyVisible = false

        if let firstIndexPath = indexPaths.first {
            let completelyVisible = isCellCompletelyVisible(at: firstIndexPath)
            leftEdgePartiallyVisible = isCellPartiallyVisible(at: firstIndexPath) && !completelyVisible
        }

        if let lastIndexPath = indexPaths.last {
            let completelyVisible = isCellCompletelyVisible(at: lastIndexPath)
            rightEdgePartiallyVisible = isCellPartiallyVisible(at: lastIndexPath) && !completelyVisible
        }

        updateGradientFrame(contentOffset, leftEdgePartiallyVisible, rightEdgePartiallyVisible)
    }

    func isCellCompletelyVisible(at indexPath: IndexPath) -> Bool {
        guard let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath) else {
            return false
        }
        let cellFrameInCollectionView = collectionView.convert(cellAttributes.frame, to: view)
        return view.frame.contains(cellFrameInCollectionView)
    }

    func isCellPartiallyVisible(at indexPath: IndexPath) -> Bool {
        guard let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath) else {
            return false
        }
        let cellFrameInCollectionView = collectionView.convert(cellAttributes.frame, to: view)
        return view.frame.intersects(cellFrameInCollectionView)
    }

    func updateGradientFrame(_ contentOffset: CGPoint, _ leftEdgePartiallyVisible: Bool, _ rightEdgePartiallyVisible: Bool) {
        gradientLayer.colors = [leftEdgePartiallyVisible ? UIColor.clear.cgColor : UIColor.black.cgColor,
                                UIColor.black.cgColor,
                                UIColor.black.cgColor,
                                rightEdgePartiallyVisible ? UIColor.clear.cgColor : UIColor.black.cgColor]

        gradientLayer.frame = CGRect(x: contentOffset.x,
                                     y: 0,
                                     width: collectionView.bounds.width,
                                     height: collectionView.bounds.height)
    }
}

extension HorizontalFadeAwayViewController: CALayerDelegate {
    func action(for layer: CALayer, forKey event: String) -> (any CAAction)? {
        NSNull()
    }
}
