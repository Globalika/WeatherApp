//
//  HourForecastCell.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

class HourForecastCell: UICollectionViewCell {
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
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            //stack.widthAnchor.constraint(equalToConstant: 50),
            //stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        setupSubViews()
    }

    func setupSubViews() {
        stack.addArrangedSubview(timeLabel)
        stack.addArrangedSubview(weatherImage)
        stack.addArrangedSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            weatherImage.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor)
        ])
    }
}
