//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Foundation
import Alamofire

protocol SearchViewModelDelegate: AnyObject {
    func onCitiesChanged()
    func onError(_ error: AFError)
}

class SearchViewModel {
    var cities: [City] = [] {
        didSet {
            delegate?.onCitiesChanged()
        }
    }
    var service = CityServices(httpClient: HttpClient())
    weak var delegate: SearchViewModelDelegate?

    func getCities(for key: String) {
        service.keywordForCities(key) { [weak self] result in
            switch result {
            case .success(let data):
                if let jsonDict = try? (JSONSerialization.jsonObject(with: data) as? [String: Any]),
                   let list = jsonDict["data"] as? [Any] {
                    self?.cities = list.compactMap { $0 as? [String: Any] }
                        .compactMap { City(from: $0) }
                }
            case .failure(let error):
                self?.delegate?.onError(error)
            }
        }
    }
}
