//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

protocol HomeFlow: AnyObject {
    func coordinateToMap()
    func coordinateToSearch()
}

class HomeCoordinator: Coordinator, HomeFlow {
    var navigationController: UINavigationController
    var homeViewController = HomeViewController(HomeViewModel(),
                                                locationManager: LocationManager())

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func coordinateToMap() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController,
                                            parentViewController: homeViewController)
        coordinate(to: mapCoordinator)
    }

    func coordinateToSearch() {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController,
                                                  parentViewController: homeViewController)
        coordinate(to: searchCoordinator)
    }
}
