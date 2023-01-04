//
//  Wind.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

struct Wind: Codable {
    var speed: Double = 0
    var deg: Int = 0
}

extension Wind {
    init?(from dictionary: [String : Any]) {
        if let speed = dictionary["speed"] as? Double,
           let deg = dictionary["deg"] as? Int {
            self.speed = speed
            self.deg = deg
        } else { return nil }
    }
}
