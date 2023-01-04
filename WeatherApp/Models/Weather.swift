//
//  Weather.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

protocol Dated {
    var date: Date { get }
}

struct Weather: Dated, Codable {
    var date: Date = Date.getDate()
    var minTemp: Temperature = Temperature(celsius: 0)
    var maxTemp: Temperature = Temperature(celsius: 0)
    var humidity: Double = 0
    var wind: Wind = Wind()
    var weather: String = ""
}

extension Weather {
    init?(from dictionary: [String: Any]) {
        if let dateStr = dictionary["dt_txt"] as? String {
            self.date = Date.getDate(from: dateStr)
        } else { return nil }
        if let main = dictionary["main"] as? [String: Any] {
            if let minTemp = main["temp_min"] as? Double,
               let maxTemp = main["temp_max"] as? Double,
               let humidity = main["humidity"] as? Double {
                self.minTemp = Temperature(kelvin: minTemp)
                self.maxTemp = Temperature(kelvin: maxTemp)
                self.humidity = humidity
            }
        } else { return nil }
        if let wind = dictionary["wind"] as? [String: Any] {
            self.wind = Wind(from: wind) ?? Wind()
        } else { return nil }
        if let weather = dictionary["weather"] as? [[String: Any]],
           let first = weather.first,
           let main = first["main"] as? String {
            self.weather = main
        } else { return nil }
    }
}
