//
//  DetailStack.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 05.01.2023.
//

import UIKit

class DetailStack: UIStackView {
    var leftImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
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
        return image
    }()
    func setup(full: Bool) {
        self.axis = .horizontal
        rightImage.isHidden = !full
        info.textColor = .weatherWhiteColor
        configure()
    }
    func configure() {
        self.addSubview(leftImage)
        self.addSubview(info)
        self.addSubview(rightImage)
        NSLayoutConstraint.activate([
            leftImage.topAnchor.constraint(equalTo: self.topAnchor),
            leftImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightImage.topAnchor.constraint(equalTo: self.topAnchor),
            rightImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            leftImage.trailingAnchor.constraint(equalTo: info.leadingAnchor),
            info.trailingAnchor.constraint(equalTo: rightImage.leadingAnchor)
        ])
    }
}
