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
    func onHourDataChanged()
    func onDayDataChanged()
    func onCityNameChanged()
}

class HomeViewModel {
    var currentCityMain: Main = Main() {
        didSet {
            delegate?.onDataChanged()
        }
    }
    var cityName: String = "" {
        didSet {
            delegate?.onCityNameChanged()
        }
    }
    var listOfDayForecast: [Main] = [] {
        didSet {
            delegate?.onDayDataChanged()
        }
    }
    var listOfHourForecast: [Main] = [] {
        didSet {
            delegate?.onHourDataChanged()
        }
    }
    var citiesService = CityServices(httpClient: HttpClient())
    var weatherService = WeatherServices(httpClient: HttpClient())
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

    @discardableResult
    func forecastForToday(location: CLLocation) -> Main? {
        weatherService.forecastForLatLon(location.coordinate.latitude,
                                         location.coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let data):
                if let jsonDict = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]),
                   let weatherList = jsonDict["list"] as? [Any],
                   let city = jsonDict["city"] as? [String: Any],
                   let name = city["name"] as? String {
                    self?.cityName = name
                    self?.listOfHourForecast = weatherList
                        .compactMap { $0 as? [String: Any] }
                        .compactMap { Main(from: $0) }
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
                            self?.listOfDayForecast.append(Main(date: date,
                                                                minTemp: min.minTemp,
                                                                maxTemp: max.maxTemp,
                                                                humidity: humidity,
                                                                wind: wind,
                                                                weather: weather))
                        }
                    }
                    if let main = self?.listOfDayForecast.first {
                        self?.currentCityMain = main
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        return currentCityMain
    }
}
