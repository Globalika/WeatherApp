//
//  ConfigurationManager.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

class ConfigurationManager {

    static let sharedInstance = ConfigurationManager()
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
    func getCitiesApiKey() -> String? {
        guard let apiKey = properties?["CITIES_API_KEY"] as? String else {
            return ""
        }
        return apiKey
    }
}
