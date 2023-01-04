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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let homeViewController = HomeViewController(HomeViewModel(),
                                                    locationManager: LocationManager())
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    func coordinateToMap() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController)
        coordinate(to: mapCoordinator)
    }
    func coordinateToSearch() {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        coordinate(to: searchCoordinator)
    }
}
