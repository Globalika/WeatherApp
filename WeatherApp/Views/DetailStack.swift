//
//  DetailStack.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 05.01.2023.
//

import UIKit

class DetailStack: UIStackView {
    private enum Constants {
        static let stackSpacing: CGFloat = 5
    }
    var leftImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    var info: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var rightImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    func setup(full: Bool) {
        axis = .horizontal
        rightImage.isHidden = !full
        info.textColor = .weatherWhiteColor
        distribution = .equalSpacing
        alignment = .center
        spacing = Constants.stackSpacing
        configure()
    }

    func configure() {
        self.addArrangedSubview(leftImage)
        self.addArrangedSubview(info)
        self.addArrangedSubview(rightImage)
        NSLayoutConstraint.activate([
            leftImage.heightAnchor.constraint(equalTo: info.heightAnchor, multiplier: 1.3),
            rightImage.heightAnchor.constraint(equalTo: info.heightAnchor, multiplier: 1.3),
            leftImage.centerYAnchor.constraint(equalTo: info.centerYAnchor),
            rightImage.centerYAnchor.constraint(equalTo: info.centerYAnchor)
        ])
    }
}
