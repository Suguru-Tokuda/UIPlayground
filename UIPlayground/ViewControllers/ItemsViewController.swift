//
//  ItemsViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import UIKit

class ItemsViewController: UIViewController {
    var vm: ItemsViewModel = ItemsViewModel()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let collectionView: ItemCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = ItemCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        loadData()
        
        vm.itemsUpdated = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        contentView.addSubview(collectionView)
    }

    private func applyConstraints() {
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]

        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 88),
            collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}

extension ItemsViewController {
    private func loadData() {
        vm.loadItems()
    }
}

extension ItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vm.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(itemModel: vm.items[indexPath.row])
        return cell
    }
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    /*
     figma spec
     screen width: 375
     screen height: 812
     item width: 280
     item height: 88
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width * 0.74666667
        let maxWidth: CGFloat = 320
        let currentWidth: CGFloat = min(width, maxWidth)
        let height: CGFloat = 88
        return CGSize(width: currentWidth, height: height)
    }
}
