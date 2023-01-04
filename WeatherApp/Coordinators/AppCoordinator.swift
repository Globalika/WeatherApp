//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        coordinate(to: homeCoordinator)
    }
}
