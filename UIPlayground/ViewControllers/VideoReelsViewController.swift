//
//  TikTokCloneViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import UIKit

class VideoReelsViewController: UIViewController {
    private var popRecognizer: InteractivePopRecognizer?
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

    private let topGradientView: VideoReelsGradientView = {
        let gradientView = VideoReelsGradientView(
            frame: .zero,
            colors: [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1)
        )
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()

    private let bottomGradientView: VideoReelsGradientView = {
        let gradientView = VideoReelsGradientView(
            frame: .zero,
            colors: [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor],
            startPoint: CGPoint(x: 0.5, y: 1),
            endPoint: CGPoint(x: 0.5, y: 0)
        )
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()

    private let gradientHeightMultiplier = 0.2185338866

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vm.loadVideos()
        addSubscriptions()
        setInteractiveRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        applyConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        view.addSubview(topGradientView)
        view.addSubview(bottomGradientView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // topGradientView constraints
            topGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            topGradientView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: gradientHeightMultiplier),
            // bottomGradientView constrains
            bottomGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomGradientView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: gradientHeightMultiplier),
        ])
    }

    private func setInteractiveRecognizer() {
        guard let navigationController else { return }
        popRecognizer = InteractivePopRecognizer(navigationController: navigationController)
        navigationController.interactivePopGestureRecognizer?.delegate = popRecognizer
    }

    private func addSubscriptions() {
        vm.videoLoaded = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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
