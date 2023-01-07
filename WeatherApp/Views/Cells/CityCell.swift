//
//  CityCell.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 06.01.2023.
//

import UIKit

class CityCell: UITableViewCell {
    var cityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .weatherBlackColor
        label.contentMode = .center
        label.numberOfLines = 1
        return label
    }()

    func configure(_ city: City) {
        self.backgroundColor = .weatherWhiteColor
        cityLabel.text = city.name + ", " + city.countryCode
        setupUI()
    }

    func setupUI() {
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
