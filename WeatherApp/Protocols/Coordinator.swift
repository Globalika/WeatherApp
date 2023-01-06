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
    func push(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    func pop() {
        navigationController.popToRootViewController(animated: true)
    }
}
