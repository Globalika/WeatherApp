//
//  MapCoordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class MapCoordinator: Coordinator {
    var parentViewController: HomeViewController
    var navigationController: UINavigationController
    init(navigationController: UINavigationController,
         parentViewController: HomeViewController) {
        self.navigationController = navigationController
        self.parentViewController = parentViewController
    }

    func start() {
        let mapViewController = MapViewController(parentViewController.viewmodel,
                                                  locationManager: LocationManager())
        mapViewController.coordinator = self
        pushLeft(mapViewController)
    }
}
