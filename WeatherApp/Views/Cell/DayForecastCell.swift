//
//  DayForecastCell.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

class DayForecastCell: UITableViewCell {
    var weekLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .weatherBlackColor
        label.numberOfLines = 1
        return label
    }()
    var temperatureLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .weatherBlackColor
        label.numberOfLines = 1
        return label
    }()
    var weatherImage: UIImageView = {
        var image = UIImageView()
        image.tintColor = .weatherBlackColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var stack: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    func configure(_ main: Main) {
        self.backgroundColor = .weatherBlueColor
        weekLabel.text = main.getWeekFromDate()?.rawValue ?? ""
        temperatureLabel.text = main.temperatureDescription
        weatherImage.image = UIImage.weatherImage(from: main.weather)
        setupStack()
    }
    func setupStack() {
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        setupSubViews()
    }

    func setupSubViews() {
        stack.addArrangedSubview(weekLabel)
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(weatherImage)
        NSLayoutConstraint.activate([
            weekLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: weekLabel.trailingAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            weekLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            weekLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            weatherImage.topAnchor.constraint(equalTo: stack.topAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])
    }
}
