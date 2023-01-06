//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit
import MapKit

// doto - update mapcontroller
class MapViewController: UIViewController, HomeViewModelDelegate {
    // MARK: - Constants
    private enum Constants {
        static let backButtonName = "ic_back"
        static let userLocationName = "ic_my_location"
        static let region: Double = 80000
    }

    // MARK: - Properties
    var coordinator: MapCoordinator?
    var locationManager = LocationManager()
    var homeViewModel = HomeViewModel()
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .dark
        return map
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.weatherWhiteColor]
        view.backgroundColor = .weatherBlueColor
        homeViewModel.delegate = self
        configure()
        onDataChanged()
    }

    func configure() {
        setupNavigation()
        setupMap()
    }

    func onDataChanged() {
        navigationItem.title = homeViewModel.cityName
    }

    func setupNavigation() {
        createCustomNavigationBar(color: .weatherBlueColor)
        let backButton = createCustomButton(image: Constants.backButtonName,
                                            color: .weatherWhiteColor,
                                            selector: #selector(backTapped))
        let userLocationButton = createCustomButton(image: Constants.userLocationName,
                                                    color: .weatherWhiteColor,
                                                    selector: #selector(userLocationTapped))
        navigationItem.rightBarButtonItem = userLocationButton
        navigationItem.leftBarButtonItem = backButton
        statusBarBackgroundColor(color: .weatherBlueColor)
    }

    func setupMap() {
        view.addSubview(mapView)
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleUserTap))
        mapView.addGestureRecognizer(tapGesture)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

    @objc func backTapped(_ sender: UIButton) {
        coordinator?.popLeft()
    }

    @objc func userLocationTapped(_ sender: UIButton) {
        centerViewOnUserLocation()
    }

    @objc func handleUserTap(gestureReconizer: UITapGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        if mapView.annotations.count == 1 {
            mapView.removeAnnotation(mapView.annotations.last!)
        }
        mapView.addAnnotation(annotation)
        loadCityWeather(coordinate.latitude, coordinate.longitude)
    }

    private func loadCityWeather(_ lat: Double, _ lon: Double) {
        homeViewModel.forecastForToday(lat, lon)
    }

    func centerViewOnUserLocation() {
        if let location = locationManager.currentUserLocation?.coordinate {
            let region = MKCoordinateRegion.init(center: location,
                                                 latitudinalMeters: Constants.region,
                                                 longitudinalMeters: Constants.region)
            mapView.setRegion(region, animated: true)
        }
    }
}
