//
//  Temperature.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

struct Temperature: Codable {
    var tempInCelsius: Double
    
    init(celsius: Double) {
        tempInCelsius = celsius
    }
    
    init(fahrenheit: Double) {
        tempInCelsius = (fahrenheit - 32.0) * 5.0 / 9.0
    }
    var celsius: Double {
        tempInCelsius
    }
    var fahrenheit: Double {
        tempInCelsius * 9.0 / 5.0 + 32.0
    }
}
