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
        //label.contentMode = .center
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
        //label.contentMode = .center
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
        stack.spacing = 2
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
        NSLayoutConstraint.activate([

            
            weatherImage.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            //weatherImage.widthAnchor.constraint(equalTo: temperatureLabel.widthAnchor),
            //weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor)
        ])
    }
}
