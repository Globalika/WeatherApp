//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire
import CoreLocation

class HomeViewModel {
    var currentCityWeather: Weather = Weather()
    var listOfDayForecast: [Weather] = []
    var listOfHourForecast: [Weather] = []
    
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
    func forecastForToday(location: CLLocation) -> Weather? {
        weatherService.forecastForLatLon(location.coordinate.latitude,
                                         location.coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let data):
                if let jsonDict = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]),
                   let firstElement = (jsonDict["list"] as? [Any])?.first as? [String: Any],
                   let weather = Weather(from: firstElement) {
                    self?.currentCityWeather = weather
                }
            case .failure(let error):
                print(error)
            }
        }
        return nil
    }
}
