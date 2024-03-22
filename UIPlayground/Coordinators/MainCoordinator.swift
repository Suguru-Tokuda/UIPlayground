//
//  MainCoordinator.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/22/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    func startCoordinator() {
        let sampleViewTableVC = SampleViewTableViewController()
        sampleViewTableVC.setCoordinator(coordinator: self)
        self.navigationController.pushViewController(sampleViewTableVC, animated: false)
    }

    func navigate(page: PageEnum) {
        switch page {
        case .horizontalItemCollectionView:
            navigationController.pushViewController(ItemsViewController(), animated: true)
        case .videoReels:
            navigationController.pushViewController(VideoReelsViewController(), animated: true)
        }
    }
}
