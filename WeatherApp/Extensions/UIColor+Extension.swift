//
//  UIColor+Extension.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

extension UIColor {
    static var weatherBlackColor: UIColor {
        UIColor(named: "colorBlack") ?? .clear
    }
    static var weatherWhiteColor: UIColor {
        UIColor(named: "colorWhite") ?? .clear
    }
    static var weatherBlueLightColor: UIColor {
        UIColor(named: "colorBlueLight") ?? .clear
    }
    static var weatherBlueBorderColor: UIColor {
        UIColor(named: "colorBlueBorder") ?? .clear
    }
    static var weatherBlueColor: UIColor {
        UIColor(named: "colorBlue") ?? .clear
    }
}
