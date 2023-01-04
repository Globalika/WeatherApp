//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import CoreLocation

class LocationManager: LocationProvider {
    private let manager: CLLocationManager
    private let geocoder: CLGeocoder
    
    init() {
        manager = CLLocationManager()
        geocoder = CLGeocoder()
    }
    var currentUserLocation: CLLocation? {
        manager.location
    }
    
    func requestAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startUpdating()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // ffallert
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startUpdating() {
        manager.startUpdatingLocation()
    }
}
//    func getUserCoordinates(location: CLLocation) -> String {
//        if let location = locations.last {
//            let geocoder = CLGeocoder()
//
//            geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
//                if error == nil {
//                    if let firstLocation = placemarks?[0],
//                        let cityName = firstLocation.locality { // get the city name
//                        self?.locationManager.stopUpdatingLocation()
//                    }
//                }
//            }
//        }
//    }
//}
