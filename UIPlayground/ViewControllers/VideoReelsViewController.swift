//
//  TikTokCloneViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import UIKit

class VideoReelsViewController: TopNavBarLessViewController {
    private var vm: VideoReelViewModel = VideoReelViewModel()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(VideoReelsCollectionView.self, forCellWithReuseIdentifier: VideoReelsCollectionView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private var gradientHeightMultiplier = 0.2185338866
    private static let gradientColors = [UIColor.black.withAlphaComponent(0.5).cgColor,
                                         UIColor.black.withAlphaComponent(0.0).cgColor]
    private let topGradient = CAGradientLayer(colors: gradientColors)
    private let bottomGradient = CAGradientLayer(colors: gradientColors)

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.loadVideos()
        addSubscriptions()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        configureGradients()
    }

    private func setupUI() {
        view.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        view.layer.addSublayer(topGradient)
        view.layer.addSublayer(bottomGradient)
    }

    private func addSubscriptions() {
        vm.videoLoaded = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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

extension VideoReelsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.videos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoReelsCollectionView.identifier, for: indexPath) as? VideoReelsCollectionView else {
            return UICollectionViewCell()
        }

        cell.configure(with: vm.videos[indexPath.row])

        return cell
    }

    private func getVisibleIndex() -> IndexPath? {
        let visibleRect = getRectInView()
        let visiblePoint = getVisiblePoint(visibleRect)
        return collectionView.indexPathForItem(at: visiblePoint)
    }

    private func getRectInView() -> CGRect {
        CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    }

    private func getVisiblePoint(_ rect: CGRect) -> CGPoint {
        CGPoint(x: rect.midX, y: rect.midY)
    }
}

extension VideoReelsViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(getVisibleIndex()?.row ?? -1)
    }
}

extension VideoReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}
