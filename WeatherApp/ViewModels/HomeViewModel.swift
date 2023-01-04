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
                   let weatherList = jsonDict["list"] as? [Any] {
                    self?.listOfHourForecast = weatherList
                        .compactMap { $0 as? [String: Any] }
                        .compactMap { Weather(from: $0) }
                    let groupedList = self?.listOfHourForecast
                        .groupedBy(dateComponents: [.day])
                        .map { $0.value }
                    groupedList?.forEach { group in
                        if let max = group.max(by: { $0.maxTemp < $1.maxTemp }),
                           let min = group.min(by: { $0.minTemp < $1.minTemp }),
                           let wind = group.first?.wind,
                           let weather = group.first?.weather,
                           let date = group.first?.date,
                           let humidity = group.first?.humidity {
                            self?.listOfDayForecast.append(Weather(date: date,
                                                                   minTemp: min.minTemp,
                                                                   maxTemp: max.maxTemp,
                                                                   humidity: humidity,
                                                                   wind: wind,
                                                                   weather: weather))
                        }
                    }
                    if let weather = self?.listOfDayForecast.first {
                        self?.currentCityWeather = weather
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        return currentCityWeather
    }
}
