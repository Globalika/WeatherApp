//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

class HomeViewModel {
    var citiesService = CityServices(httpClient: HttpClient())
    var weatherService = WeatherServices(httpClient: HttpClient())

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
    func forecastForToday() -> Weather? {
        //service location
        var weather: Weather
        weatherService.weatherForCity("Lviv") { result in
            switch result {
            case .success(let data):
                if let jsonDict = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]) {
                    let bb = 5
                    //weather = Weather(minTemp: <#T##Temperature#>, maxTemp: <#T##Temperature#>, humidity: <#T##Double#>, wind: <#T##Wind#>)
                }
            case .failure(let error):
                print(error)
            }
        }
        return nil
    }
}
