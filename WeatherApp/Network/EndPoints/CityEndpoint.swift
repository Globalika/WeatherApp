//
//  CityEndpoint.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

enum CityEndPoints: EndPoint {
    case keywordForCities(_ keyword: String)
    var baseURL: URL {
        return URL(string: "")!
    }
    var method: HTTPMethod {
        switch self {
        case .keywordForCities:
            return .post
        }
    }
    var path: String {
        switch self {
        case .keywordForCities:
            return "keyword"
        }
    }
    var parameters: Parameters? {
        switch self {
        case let .keywordForCities(keyword):
            return ["k": keyword]
        }
    }
}
