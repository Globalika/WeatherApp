//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class SearchViewController: UIViewController, SearchViewModelDelegate, UITextViewDelegate {
    func onCitiesChanged() {
        self.citiesTableView.reloadData()
    }
    var viewmodel = SearchViewModel()
    var coordinator: SearchCoordinator?
    var searchView: UITextView = UITextView()
    private lazy var citiesTableView = UITableView()
    override func viewDidLoad() {
        view.backgroundColor = .weatherWhiteColor
        searchView.delegate = self
        viewmodel.delegate = self
        setupNavigation()
        setupDayTableView()
        setupUI()
    }
    func textViewDidChange(_ textView: UITextView) {
        viewmodel.getCities(for: textView.text)
    }
    private func setupDayTableView() {
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        self.view.addSubview(citiesTableView)
        citiesTableView.register(CityCell.self, forCellReuseIdentifier: "CityCell")
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        citiesTableView.backgroundColor = .weatherWhiteColor
        NSLayoutConstraint.activate([
            citiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            citiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    func setupNavigation() {
        createCustomNavigationBar(color: .weatherBlueColor)
        let backButton = createCustomButton(image: "ic_back",
                                           color: .weatherWhiteColor,
                                           selector: #selector(beckTapped))
        let searchButton = createCustomButton(image: "ic_search",
                                              color: .weatherWhiteColor,
                                              selector: #selector(searchTapped))
        searchView.layer.cornerRadius = 5
        searchView.textContainer.lineBreakMode = .byTruncatingTail
        searchView.textContainer.maximumNumberOfLines = 1
        searchView.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = searchView
        if let height = navigationController?.navigationBar.bounds.height,
           let width = navigationController?.navigationBar.bounds.width {
            NSLayoutConstraint.activate([
                searchView.widthAnchor.constraint(equalToConstant: width / 1.8),
                searchView.heightAnchor.constraint(equalToConstant: height * 0.8)
            ])
        }
        statusBarBackgroundColor(color: .weatherBlueColor)
    }
    @objc func beckTapped(_ sender: UIButton) {
        coordinator?.pop()
    }
    @objc func searchTapped(_ sender: UIButton) {
        //
    }
    func setupUI() {
    }
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell {
            cell.configure(viewmodel.cities[indexPath.row])
            rowCell = cell
        }
        return rowCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
