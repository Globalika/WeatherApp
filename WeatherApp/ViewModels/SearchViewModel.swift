//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation

class SearchViewModel {
    var cities: [City] = []
    var service = CityServices(httpClient: HttpClient())
    func getCities(for key: String) {
        service.keywordForCities(key) { result in
            switch result {
            case .success(let data):
                if let jsonDict = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]) {
                    //Settings.citiesApiSecret = jsonDict["access_token"] as? String ?? ""
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
