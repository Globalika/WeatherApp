//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

class WeatherServices: ServiceType {
    private var httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    func weatherForCity(_ city: String, completion: @escaping (Result<Weather, AFError>) -> Void) {
        httpClient.execute(WeatherEndPoints.weatherForCity(city), model: Weather.self, completion: completion)
    }
    func forecastForLatLon(_ lat: Double, _ lon: Double, completion: @escaping (Result<Weather, AFError>) -> Void) {
        httpClient.execute(WeatherEndPoints.forecastForLatLon(lat, lon), model: Weather.self, completion: completion)
    }
}
