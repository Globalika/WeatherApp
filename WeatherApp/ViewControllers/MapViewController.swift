//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class MapViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .cyan
        setupUI()
    }
    var button1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("left", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        return button
    }()
    var coordinator: MapCoordinator?
    @objc func leftTapped(_ sender: UIButton) {
        coordinator?.dismiss()
    }
    func setupUI() {
        view.addSubview(button1)
        button1.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
}
