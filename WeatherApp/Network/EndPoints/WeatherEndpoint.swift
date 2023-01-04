//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

enum WeatherEndPoints: EndPoint {
    case weatherForCity(_ city: String)
    case forecastForLatLon(_ lat: Double, _ lon: Double)
    var baseURL: URL {
        return URL(string: "\(ConfigurationManager.shared.getWeatherApiUrl() ?? "")")!
    }
    var method: HTTPMethod {
        switch self {
        case .weatherForCity, .forecastForLatLon:
            return .get
        }
    }
    var path: String {
        switch self {
        case .weatherForCity, .forecastForLatLon:
            return "forecast"
        }
    }
    var parameters: Parameters? {
        switch self {
        case let .weatherForCity(city):
            return ["q": city,
                    "appid": "\(ConfigurationManager.shared.getWeatherApiKey() ?? "")"]
        case let .forecastForLatLon(lat, lon):
            return ["lat": lat,
                    "lon": lon,
                    "appid": "\(ConfigurationManager.shared.getWeatherApiKey() ?? "")"]
        }
    }
    var headers: HTTPHeaders {
        let header = HTTPHeaders()
        return header
    }
}
