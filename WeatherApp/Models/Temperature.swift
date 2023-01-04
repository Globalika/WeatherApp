//
//  Temperature.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

struct Temperature: Codable {
    var tempInCelsius: Double = 0
    init(celsius: Double) {
        tempInCelsius = celsius
    }
    init(fahrenheit: Double) {
        tempInCelsius = (fahrenheit - 32.0) * 5.0 / 9.0
    }
    init(kelvin: Double) {
        tempInCelsius = kelvin - 273.15
    }
    var celsius: Double {
        tempInCelsius
    }
    var fahrenheit: Double {
        tempInCelsius * 9.0 / 5.0 + 32.0
    }
    var kelvin: Double {
        tempInCelsius + 273.15
    }
}

extension Temperature: Comparable {
    static func < (lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs.tempInCelsius < rhs.tempInCelsius
    }
}
