//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

class HomeViewModel {
    var citiesService = CityServices(httpClient: HttpClient())
    
    func autorizeCitiesApi() {
        citiesService.autorize { result in
            switch result {
            case .success(let data):
                if let jsonDict = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]) {
                    Settings.citiesApiSecret = jsonDict["access_token"] as? String ?? ""
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
