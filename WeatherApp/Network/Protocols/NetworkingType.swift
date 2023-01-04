//
//  NetworkingType.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

protocol NetworkingType {
    @discardableResult
    func execute<T: Codable>(_ endPoint: EndPoint,
                             model: T.Type,
                             completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest
}

extension NetworkingType {
    @discardableResult
    func execute<T: Codable>(_ endPoint: EndPoint,
                             model: T.Type,
                             completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        return AF.request(endPoint).responseDecodable(decoder: JSONDecoder()) { responce in
            completion(responce.result)
        }
    }
}
