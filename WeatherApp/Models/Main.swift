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

struct Main: Dated, Codable {
    var date: Date = Date.getDate()
    var minTemp: Temperature = Temperature(celsius: 0)
    var maxTemp: Temperature = Temperature(celsius: 0)
    var humidity: Double = 0
    var wind: Wind = Wind()
    var weather: Weather = Weather()
}

extension Main {
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
           let main = first["main"] as? String,
           let sys = dictionary["sys"] as? [String: Any],
           let pod = sys["pod"] as? String {
            self.weather = Weather(weather: main, isDay: pod == "d")
        } else { return nil }
    }
}

extension Main {
    var temperatureDescription: String {
        String(round(maxTemp.tempInCelsius * 10) / 10.0) + "°/" + String(round(minTemp.tempInCelsius * 10) / 10.0) + "°"
    }
    var temperatureAverage: String {
        if (maxTemp.tempInCelsius < 0 && minTemp.tempInCelsius < 0) ||
            (maxTemp.tempInCelsius > 0 && minTemp.tempInCelsius > 0) {
            return String((round(maxTemp.tempInCelsius + minTemp.tempInCelsius) / 2 * 10) / 10.0) + "°"
        } else {
            return String((round(maxTemp.tempInCelsius + minTemp.tempInCelsius) * 10) / 10.0) + "°"
        }
    }
}
