//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

class WeatherServices: ServiceType {
    private var httpClient: NetworkingType
    init(httpClient: NetworkingType) {
        self.httpClient = httpClient
    }

    func weatherForCity(_ city: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        httpClient.execute(WeatherEndPoints.weatherForCity(city), completion: completion)
    }

    func forecastForLatLon(_ lat: Double, _ lon: Double, completion: @escaping (Result<Data, AFError>) -> Void) {
        httpClient.execute(WeatherEndPoints.forecastForLatLon(lat, lon), completion: completion)
    }
}
