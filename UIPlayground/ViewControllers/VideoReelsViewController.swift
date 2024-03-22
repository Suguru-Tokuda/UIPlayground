//
//  TikTokCloneViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/21/24.
//

import UIKit

class VideoReelsViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vm.loadVideos()
        addSubscriptions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func setupUI() {
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
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
}

extension VideoReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}
