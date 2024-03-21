//
//  ItemsViewController.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import UIKit

class ItemsViewController: UIViewController {
    var vm: ItemsViewModel = ItemsViewModel()

    /*
     figma spec
     screen width: 375
     screen height: 812
     item width: 280
     item height: 88
     */
    private let collectionView: ItemCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.74666667, height: 88)
        layout.scrollDirection = .horizontal
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
        loadData()
        
        vm.itemsUpdated = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }

    private func applyConstraints() {
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 88),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ]

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
