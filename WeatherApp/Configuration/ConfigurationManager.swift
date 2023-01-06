//
//  ConfigurationManager.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

class ConfigurationManager {

    static let shared = ConfigurationManager()
    var properties: NSDictionary?
    private init() {}
    func setProperties(source: NSDictionary) {
        self.properties = source
    }

    func getWeatherApiKey() -> String? {
        guard let apiKey = properties?["WEATHER_API_KEY"] as? String else {
            return ""
        }
        return apiKey
    }

    func getWeatherApiUrl() -> String? {
        guard let apiUrl = properties?["WEATHER_API_URL"] as? String else {
            return ""
        }
    
        return apiUrl
    }

    func getCitiesApiKey() -> String? {
        guard let apiKey = properties?["CITIES_API_KEY"] as? String else {
            return ""
        }
        return apiKey
    }

    func getCitiesApiUrl() -> String? {
        guard let apiUrl = properties?["CITIES_API_URL"] as? String else {
            return ""
        }
        return apiUrl
    }

    func getCitiesApiSecret() -> String? {
        guard let apiSecret = properties?["CITIES_API_SECRET"] as? String else {
            return ""
        }
        return apiSecret
    }
}
