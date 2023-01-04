//
//  ViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Lifecycle
    var viewmodel: HomeViewModel
    var locationManager: LocationProvider
    init(_ viewmodel: HomeViewModel, locationManager: LocationProvider) {
        self.viewmodel = viewmodel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.autorizeCitiesApi()
        setupUI()
        locationManager.requestAuthorization()
        if let location = locationManager.currentUserLocation {
            let weather = viewmodel.forecastForToday(location: location)
        }
    }
    var button1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("left", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        return button
    }()
     var button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("right", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
        return button
    }()
    @objc func leftTapped(_ sender: UIButton) {
        //viewmodel.forecastForToday(location: <#T##CLLocation#>)
        coordinator?.coordinateToMap()
    }
    @objc func rightTapped(_ sender: UIButton) {
        coordinator?.coordinateToSearch()
    }
    func setupUI() {
        self.view.backgroundColor = .blue
        view.addSubview(button1)
        view.addSubview(button2)
        button1.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        button2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    // MARK: - Properties
    var coordinator: HomeFlow?
}
