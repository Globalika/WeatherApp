//
//  CityEndpoint.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

enum CityEndPoints: EndPoint {
    case keywordForCities(_ keyword: String)
    case autorization
    var baseURL: URL {
        return URL(string: "\(ConfigurationManager.shared.getCitiesApiUrl() ?? "")")!
    }
    var method: HTTPMethod {
        switch self {
        case .keywordForCities:
            return .get
        case .autorization:
            return .post
        }
    }
    var path: String {
        switch self {
        case .keywordForCities:
            return "reference-data/locations/cities"
        case .autorization:
            return "security/oauth2/token"
        }
    }
    var parameters: Parameters? {
        switch self {
        case let .keywordForCities(keyword):
            return ["keyword": keyword, "max": 10]
        case .autorization:
            return ["grant_type": "client_credentials",
                    "client_id": ConfigurationManager.shared.getCitiesApiKey() ?? "",
                    "client_secret": ConfigurationManager.shared.getCitiesApiSecret() ?? ""]
        }
    }
    var headers: HTTPHeaders {
        switch self {
        case .keywordForCities(_):
            return [.authorization(bearerToken: Settings.citiesApiSecret)]
        case .autorization:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }
    }
}
