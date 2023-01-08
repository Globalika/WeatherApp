//
//  DayForecastCell.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 04.01.2023.
//

import UIKit

class DayForecastCell: UITableViewCell {
    private enum Constants {
        static let stackMargins =  UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

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
        self.selectionStyle = .none
        layer.shadowColor = UIColor.weatherBlueBorderColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        let shadowFrame: CGRect = layer.bounds
        let shadowPath: CGPath = UIBezierPath(rect: shadowFrame).cgPath
        layer.shadowPath = shadowPath
        layer.masksToBounds = false
        weekLabel.text = main.date.week
        temperatureLabel.text = main.temperatureDescription
        temperatureLabel.textAlignment = .center
        weatherImage.image = UIImage.weatherImage(from: main.weather)?.withRenderingMode(.alwaysTemplate)
        setupStack()
    }

    func setupStack() {
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.layoutMargins = Constants.stackMargins
        stack.isLayoutMarginsRelativeArrangement = true
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        self.color = selected ? .weatherBlueColor : .weatherBlackColor
        layer.shadowOpacity = selected ? 1 : 0
        layer.zPosition = selected ? 50 : 0
        setupSubViews()
    }
}
