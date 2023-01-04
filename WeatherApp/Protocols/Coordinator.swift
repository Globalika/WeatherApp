//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func coordinate(to coordinator: Coordinator)
    func start()
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
    func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }
    func dismiss() {
        guard let presentedNavController = navigationController.presentedViewController else { return }
        presentedNavController.dismiss(animated: true)
    }
}
