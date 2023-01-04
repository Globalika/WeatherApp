//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .cyan
        setupUI()
    }
    var button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("right", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
        return button
    }()
    var coordinator: SearchCoordinator?
    @objc func rightTapped(_ sender: UIButton) {
        coordinator?.dismiss()
    }
    func setupUI() {
        view.addSubview(button2)
        button2.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
