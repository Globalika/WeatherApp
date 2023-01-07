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
        label.numberOfLines = 1
        return label
    }()
    var temperatureLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    var weatherImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    var stack: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private var color: UIColor = .weatherBlackColor
    func configure(_ main: Main) {
        self.backgroundColor = .weatherWhiteColor
        weekLabel.text = main.date.week
        temperatureLabel.text = main.temperatureDescription
        temperatureLabel.textAlignment = .center
        weatherImage.image = UIImage.weatherImage(from: main.weather)?.withRenderingMode(.alwaysTemplate)
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
        weekLabel.textColor = color
        temperatureLabel.textColor = color
        weatherImage.tintColor = color
        stack.addArrangedSubview(weekLabel)
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(weatherImage)
        NSLayoutConstraint.activate([
            weekLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        self.color = selected ? .weatherBlueColor : .weatherBlackColor
        setupSubViews()
    }
}
