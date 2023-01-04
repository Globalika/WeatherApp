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
        let path = Bundle.main.path(forResource: "WeatherApp", ofType: "plist")
        let dict = NSDictionary.init(contentsOfFile: path!)
        ConfigurationManager.shared.setProperties(source: dict!)
        
        let window = UIWindow()
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        return true
    }
}
