//
//  CityServices.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

class CityServices: ServiceType {
    private var httpClient: NetworkingType

    init(httpClient: NetworkingType) {
        self.httpClient = httpClient
    }

    func keywordForCities(_ keyword: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        httpClient.execute(CityEndPoints.keywordForCities(keyword), completion: completion)
    }

    func autorize(completion: @escaping (Result<Data, AFError>) -> Void) {
        httpClient.execute(CityEndPoints.autorization, completion: completion)
    }
}
