//
//  CityInfoView.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

class CityInfoView: UIView {
    private var cityMain: Main = Main()
    private var detailImages = [
        UIImage(named: "ic_temp"),
        UIImage(named: "ic_humidity"),
        UIImage(named: "ic_wind")
    ]
    private var info: [String] {
        return [cityMain.temperatureDescription,
                String(cityMain.humidity),
                cityMain.wind.speedDescription]
    }
    private var weatherImage = UIImage()
    private var windImage = UIImage()
    var weatherImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var weatherStack: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    var weatherRightStack: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 2
        stack.axis = .vertical
        return stack
    }()
    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .weatherWhiteColor
        return label
    }()

    func setup(cityMain: Main) {
        self.cityMain = cityMain
        self.weatherImage = UIImage.weatherImage(from: cityMain.weather) ?? UIImage()
        self.windImage = UIImage.windImage(from: cityMain.wind) ?? UIImage()
        clearUp()
        setupDateLabel()
        setupWeatherStack()
        setupWetherImageView()
        setupWeatherRightStack()
    }

    private func clearUp() {
        for view in weatherStack.subviews {
            view.removeFromSuperview()
        }
        for view in weatherRightStack.subviews {
            view.removeFromSuperview()
        }
    }

    private func setupDateLabel() {
        dateLabel.text = cityMain.date.week + ", " + cityMain.date.day + " " + cityMain.date.month
        self.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }

    private func setupWeatherStack() {
        self.addSubview(weatherStack)
        NSLayoutConstraint.activate([
            weatherStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            weatherStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }

    private func setupWetherImageView() {
        weatherImageView.image = weatherImage
        weatherStack.addArrangedSubview(weatherImageView)
    }

    private func setupWeatherRightStack() {
        for (index, image) in detailImages.enumerated() {
            let stack = DetailStack()
            let full = index == detailImages.count - 1
            stack.setup(full: full, vertical: false)
            stack.leftImage.image = image
            stack.info.text = info[index]
            stack.rightImage.image = full ? windImage : UIImage()
            stack.spacing = 2
            stack.distribution = .fill
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            weatherRightStack.addArrangedSubview(stack)
            NSLayoutConstraint.activate([
                stack.leadingAnchor.constraint(equalTo: weatherRightStack.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: weatherRightStack.trailingAnchor)
            ])
        }
        weatherStack.addArrangedSubview(weatherRightStack)
        NSLayoutConstraint.activate([
            weatherRightStack.topAnchor.constraint(equalTo: weatherStack.topAnchor),
            weatherRightStack.bottomAnchor.constraint(equalTo: weatherStack.bottomAnchor)
        ])
    }
}
