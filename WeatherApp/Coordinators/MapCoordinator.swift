//
//  MapCoordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class MapCoordinator: Coordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mapViewController = MapViewController()
        mapViewController.coordinator = self
        pushLeft(mapViewController)
    }
}
