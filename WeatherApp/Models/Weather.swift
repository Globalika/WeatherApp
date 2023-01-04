//
//  Weather.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

struct Weather: Codable {
    var minTemp: Temperature
    var maxTemp: Temperature
    var humidity: Double
    var wind: Wind
}
