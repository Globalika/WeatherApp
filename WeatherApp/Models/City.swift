//
//  City.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

struct City: Codable {
    var name: String = ""
    var countryCode: String = ""
}

extension City {
    init?(from dictionary: [String: Any]) {
        if let name = dictionary["name"] as? String,
           let addr = dictionary["address"] as? [String: Any],
           let countryCode = addr["countryCode"] as? String {
            self.name = name
            self.countryCode = countryCode
        } else { return nil }
    }
}
