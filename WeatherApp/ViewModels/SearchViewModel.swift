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
                //self.cities =
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
