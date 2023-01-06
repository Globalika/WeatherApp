//
//  SearchCoordinator.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class SearchCoordinator: Coordinator {
    var parentViewController: HomeViewController
    var navigationController: UINavigationController
    init(navigationController: UINavigationController,
         parentViewController: HomeViewController) {
        self.navigationController = navigationController
        self.parentViewController = parentViewController
    }

    func start() {
        let searchViewController = SearchViewController(parentViewController.viewmodel)
        searchViewController.coordinator = self
        push(searchViewController)
    }
}
