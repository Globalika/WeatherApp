//
//  SearchCoordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let searchViewController = SearchViewController()
        searchViewController.coordinator = self
        present(searchViewController)
    }
}
