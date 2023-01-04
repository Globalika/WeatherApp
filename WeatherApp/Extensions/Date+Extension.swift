//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

extension Date {
    static func getDate(from str: String = "2022/12/17 22:17:00",
                        with format: String = "yyyy/MM/dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: str) ?? Date(timeIntervalSince1970: TimeInterval.pi)
    }
}
