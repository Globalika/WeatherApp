//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire
import CoreLocation

protocol HomeViewModelDelegate: AnyObject {
    func onDataChanged()
}

class HomeViewModel {
    var currentCityMain: Main = Main() {
        didSet {
            delegate?.onDataChanged()
        }
    }
    var cityName: String = ""
    var listOfDayForecast: [Main] = []
    var listOfHourForecast: [Main] = []
    private var citiesService = CityServices(httpClient: HttpClient())
    private var weatherService = WeatherServices(httpClient: HttpClient())
    weak var delegate: HomeViewModelDelegate?

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

    func forecastForToday(cityName: String) {
        weatherService.weatherForCity(cityName) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parse(data)
            case .failure(let error):
                print(error)
            }
        }
    }

    func forecastForToday(_ lat: Double, _ lon: Double) {
        weatherService.forecastForLatLon(lat, lon) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parse(data)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func parse(_ data: Data) {
        cityName = ""
        listOfHourForecast = []
        listOfDayForecast = []
        if let dictionary = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]),
           let weatherList = dictionary["list"] as? [Any],
           let city = dictionary["city"] as? [String: Any],
           let name = city["name"] as? String {
            cityName = name
            listOfHourForecast = weatherList
                .compactMap { $0 as? [String: Any] }
                .compactMap { Main(from: $0) }
            let groupedList = listOfHourForecast
                .groupedBy(dateComponents: [.day])
                .map { $0.value }
            groupedList.forEach { group in
                if let max = group.max(by: { $0.maxTemp < $1.maxTemp }),
                   let min = group.min(by: { $0.minTemp < $1.minTemp }),
                   let wind = group.first?.wind,
                   let weather = group.first?.weather,
                   let date = group.first?.date,
                   let humidity = group.first?.humidity {
                    listOfDayForecast.append(Main(date: date,
                                                  minTemp: min.minTemp,
                                                  maxTemp: max.maxTemp,
                                                  humidity: humidity,
                                                  wind: wind,
                                                  weather: weather))
                }
            }
            listOfHourForecast = listOfHourForecast[...(listOfHourForecast.count / 5)].asArray()
            listOfDayForecast = listOfDayForecast.sorted(by: { $0.date < $1.date })
            if let main = listOfDayForecast.first {
                currentCityMain = main
            }
        }
    }
}
