//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        return true
    }
}
