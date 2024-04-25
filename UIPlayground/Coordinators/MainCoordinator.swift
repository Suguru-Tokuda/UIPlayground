//
//  MainCoordinator.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/22/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = CustomNavigationController()

    func startCoordinator() {
        let mainTableViewController = MainTableViewController()
        mainTableViewController.setCoordinator(coordinator: self)
        self.navigationController.pushViewController(mainTableViewController, animated: false)
    }

    func navigate(page: PageEnum) {
        var viewController: UIViewController?

        switch page {
        case .horizontalFadeAwayViewController:
            viewController = HorizontalFadeAwayViewController()
        case .horizontalItemCollectionView:
            viewController = ItemsViewController()
        case .videoReels:
            viewController = VideoReelsViewController()
        case .scrollViewPaginationViewController:
            viewController = ScrollViewPaginationViewController()
        case .topBottomGradientViewController:
            viewController = TopBottomGradientViewController()
        case .testViewController:
            viewController = TestViewController()
        }

        if let viewController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
