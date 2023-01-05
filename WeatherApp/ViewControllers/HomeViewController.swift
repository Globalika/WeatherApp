//
//  ViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class HomeViewController: UIViewController, ViewModelDelegate {
    func onDataChanged() {
        configureUI()
    }
    // MARK: - Lifecycle
    var viewmodel: HomeViewModel
    var locationManager: LocationProvider
    // MARK: - Properties
    var coordinator: HomeFlow?
    init(_ viewmodel: HomeViewModel, locationManager: LocationProvider) {
        self.viewmodel = viewmodel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
        viewmodel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        self.view.backgroundColor = UIColor.weatherBlueColor
        configureLocation()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    var cityInfoView: CityInfoView = {
        var view = CityInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func configureUI() {
        setupCityInfoView()
    }
    func setupCityInfoView() {
        cityInfoView.setup(cityMain: viewmodel.currentCityMain)
        self.view.addSubview(cityInfoView)
        NSLayoutConstraint.activate([
            cityInfoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cityInfoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            cityInfoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            cityInfoView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    func configureLocation() {
        viewmodel.autorizeCitiesApi()
        locationManager.requestAuthorization()
        if let location = locationManager.currentUserLocation {
            viewmodel.forecastForToday(location: location)
        }
    }
}

//var button1: UIButton = {
//    let button = UIButton()
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setTitle("left", for: .normal)
//    button.backgroundColor = .red
//    button.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
//    return button
//}()
// var button2: UIButton = {
//    let button = UIButton()
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setTitle("right", for: .normal)
//    button.backgroundColor = .green
//    button.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
//    return button
//}()
//@objc func leftTapped(_ sender: UIButton) {
//    //viewmodel.forecastForToday(location: <#T##CLLocation#>)
//    coordinator?.coordinateToMap()
//}
//@objc func rightTapped(_ sender: UIButton) {
//    coordinator?.coordinateToSearch()
//}
//        self.view.backgroundColor = .blue
//        view.addSubview(button1)
//        view.addSubview(button2)
//        button1.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        button1.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button1.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        button2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button2.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        button2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
