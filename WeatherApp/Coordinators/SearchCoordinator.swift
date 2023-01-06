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
//        let button = UIButton(type: .system)
//        button.setImage(
//            UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate),
//            for: .normal
//        )
//        button.tintColor = .weatherWhiteColor
//        button.imageView?.contentMode = .scaleAspectFit
//        button.contentVerticalAlignment = .fill
//        button.contentHorizontalAlignment = .fill
//        navigationController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
//        searchViewController.navigationController?.title = "fff"
//        navigationController.navigationBar.barTintColor = .green
        push(searchViewController)
    }
}
