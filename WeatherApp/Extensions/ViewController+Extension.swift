//
//  ViewController+Extension.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

extension UIViewController {
    func createCustomNavigationBar(color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
    }
    func createCustomButton(image: String,
                            title: String = "",
                            color: UIColor,
                            selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(named: image)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        if !title.isEmpty {
            button.setTitle(title, for: .normal)
        }
        button.tintColor = color
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    func createTextView(view: UITextView) -> UIBarButtonItem {
        view.contentMode = .left
        return UIBarButtonItem(customView: view)
    }
    func statusBarBackgroundColor(color: UIColor) {
        let view = UIView(frame: CGRect(x: 0.0,
                                        y: 0.0,
                                        width: UIScreen.main.bounds.size.width,
                                        height: UIApplication.shared.statusBarFrame.height)
        )
        view.backgroundColor = color
        self.view.addSubview(view)
    }
}

//
//protocol Allerts {
//    func showError(_ error: Error, _ title: String?, _ actions: [(String, ExecuteAction?)]? )
//    func showMessage(_ message: String?, _ title: String?, _ actions: [(String, ExecuteAction?)]?,
//                     dismissTime: TimeInterval?, _ completion: (() -> Void)?)
//}
//
//extension Allerts where Self: UIViewController {
//
//    func showError(_ error: Error, _ title: String?, _ actions: [(String, ExecuteAction?)]? = [("Ok", nil)]) {
//        let alert = UIAlertController(title: title,
//                                      message: error.message(),
//                                      preferredStyle: .alert)
//        actions?.forEach { action in
//            alert.addAction(UIAlertAction(title: action.0, style: .default, handler: action.1))
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func showMessage(_ message: String?, _ title: String?, _ actions: [(String, ExecuteAction?)]? = [("Ok", nil)],
//                     dismissTime: TimeInterval? = nil, _ completion: (() -> Void)? = nil) {
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        actions?.forEach { action in
//            alert.addAction(UIAlertAction(title: action.0, style: .default, handler: action.1))
//        }
//        self.present(alert, animated: true, completion: nil)
//        dismissAfter(alert, dismissTime, completion)
//    }
//
//    private func dismissAfter(_ alert: UIAlertController?, _ interval: TimeInterval?, _ completion: (() -> Void)? = nil) {
//        guard let interval = interval
//        else { return }
//        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak alert, completion] in
//            alert?.dismiss(animated: true)
//            completion?()
//        }
//    }
//}
