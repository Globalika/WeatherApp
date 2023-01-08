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
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
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
