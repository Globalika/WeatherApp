//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

extension Date {
    static func getDate(from str: String = "2022/12/17 22:17:00",
                        with format: String = Constants.fullDateFormat) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: str) ?? Date(timeIntervalSince1970: TimeInterval.pi)
    }
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.monthFormat
        return dateFormatter.string(from: self)
    }
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dayFormat
        return dateFormatter.string(from: self)
    }
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.hourFormat
        return dateFormatter.string(from: self)
    }

    private enum Constants {
        static let monthFormat = "MMMM"
        static let hourFormat = "hh:mm"
        static let dayFormat = "dd"
        static let fullDateFormat = "yyyy/MM/dd HH:mm:ss"
    }
}
