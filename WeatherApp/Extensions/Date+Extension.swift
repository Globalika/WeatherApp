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
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self)
    }
}
