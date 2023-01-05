//
//  UIImage+Extension.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 05.01.2023.
//

import UIKit

extension UIImage {
    static func windImage(from wind: Wind) -> UIImage? {
        //let degree = (wind.deg % 360) < 0 ? (wind.deg % 360) + 360 : (wind.deg % 360)
        switch wind.deg {
        case 0...22, 338...359:
            return UIImage(named: "icon_wind_n")
        case 23...67:
            return UIImage(named: "icon_wind_ne")
        case 68...112:
            return UIImage(named: "icon_wind_e")
        case 113...157:
            return UIImage(named: "icon_wind_se")
        case 158...202:
            return UIImage(named: "icon_wind_s")
        case 203...247:
            return UIImage(named: "icon_wind_ws")
        case 248...292:
            return UIImage(named: "icon_wind_w")
        case 293...337:
            return UIImage(named: "icon_wind_wn")
        default:
            return UIImage()
        }
    }
    static func weatherImage(from weather: Weather) -> UIImage? {
        switch weather.weather {
        case "Rain":
            return weather.isDay
            ? UIImage(named: "ic_white_day_rain")
            : UIImage(named: "ic_white_night_rain")
        case "Snow":
            return weather.isDay
            ? UIImage(named: "ic_white_day_thunder")
            : UIImage(named: "ic_white_night_thunder")
        case "Clouds":
            return weather.isDay
            ? UIImage(named: "ic_white_day_cloudy")
            : UIImage(named: "ic_white_night_cloudy")
        case "Clear":
            return weather.isDay
            ? UIImage(named: "ic_white_day_bright")
            : UIImage(named: "ic_white_night_bright")
        default:
            return weather.isDay
            ? UIImage(named: "ic_white_day_shower")
            : UIImage(named: "ic_white_night_shower")
        }
    }
}
