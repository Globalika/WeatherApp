//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import CoreLocation

protocol LocationProvider {
    var currentUserLocation: CLLocation? { get }
    func requestAuthorization()
    func startUpdating()
}
