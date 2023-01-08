//
//  Alerts+Error.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 08.01.2023.
//

import Foundation
import Alamofire

typealias ExecuteAction = (UIAlertAction) -> Void

protocol Allerts {
    func showError(_ error: AFError, _ title: String?, _ actions: [(String, ExecuteAction?)]? )
}

extension Allerts where Self: UIViewController {
    func showError(_ error: AFError, _ title: String?, _ actions: [(String, ExecuteAction?)]? = [("Ok", nil)]) {
        let alert = UIAlertController(title: title,
                                      message: error.message(),
                                      preferredStyle: .alert)
        actions?.forEach { action in
            alert.addAction(UIAlertAction(title: action.0, style: .default, handler: action.1))
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension AFError {
    func message () -> String {
        if let message = (self as NSError).userInfo["message"] as? String {
            return message
        }
        return self.errorDescription ?? localizedDescription
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
