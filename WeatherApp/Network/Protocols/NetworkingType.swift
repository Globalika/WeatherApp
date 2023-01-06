//
//  NetworkingType.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import Alamofire

protocol NetworkingType {
    @discardableResult
    func execute(_ endPoint: EndPoint,
                 completion: @escaping (Result<Data, AFError>) -> Void) -> DataRequest
}

extension NetworkingType {
    @discardableResult
    func execute(_ endPoint: EndPoint,
                 completion: @escaping (Result<Data, AFError>) -> Void) -> DataRequest {
        return AF.request(endPoint).responseData(completionHandler: { responce in
            completion(responce.result)
        })
    }
}
