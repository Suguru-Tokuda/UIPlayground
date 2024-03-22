//
//  Coordinator.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/22/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get set }
    func startCoordinator()
}
