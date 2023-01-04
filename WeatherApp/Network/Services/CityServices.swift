//
//  CityServices.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

class CityServices: ServiceType {
    private var httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    func keywordFroCities(_ keyword: String, completion: @escaping (Result<City, AFError>) -> Void) {
        httpClient.execute(CityEndPoints.keywordForCities(keyword), model: City.self, completion: completion)
    }
}
