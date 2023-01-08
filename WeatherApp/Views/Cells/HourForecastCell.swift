//
//  HourForecastCell.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

class HourForecastCell: UICollectionViewCell {
    private enum Constants {
        static let stackMargins =  UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        static let stackSpacing: CGFloat = 2
    }

    var timeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .weatherWhiteColor
        label.numberOfLines = 1
        return label
    }()
    var weatherImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var temperatureLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .weatherWhiteColor
        label.numberOfLines = 1
        return label
    }()
    var stack: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    func configure(_ main: Main) {
        self.backgroundColor = .weatherBlueLightColor
        timeLabel.text = main.date.hour
        weatherImage.image = UIImage.weatherImage(from: main.weather)
        temperatureLabel.text = main.temperatureAverage
        setupStack()
    }

    func setupStack() {
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = Constants.stackSpacing
        stack.layoutMargins = Constants.stackMargins
        stack.isLayoutMarginsRelativeArrangement = true
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        setupSubViews()
    }

    func setupSubViews() {
        stack.addArrangedSubview(timeLabel)
        stack.addArrangedSubview(weatherImage)
        stack.addArrangedSubview(temperatureLabel)
    }
}
