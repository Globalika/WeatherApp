//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class SearchViewController: UIViewController, SearchViewModelDelegate, UITextViewDelegate {
    // MARK: - Constants
    private enum Constants {
        static let cityCellID = "CityCell"
        static let backButtonName = "ic_back"
        static let searchButtonName = "ic_search"
        static let searchViewCornerRadius: CGFloat = 5
        static let searchHint = "Minimin 3 characters"
    }
    // MARK: - Properties
    var viewmodel = SearchViewModel()
    weak var homeViewModel: HomeViewModel?
    var coordinator: SearchCoordinator?
    var searchView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = Constants.searchViewCornerRadius
        view.textContainer.lineBreakMode = .byTruncatingTail
        view.textContainer.maximumNumberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = Constants.searchHint
        return view
    }()
    private lazy var citiesTableView = UITableView()

    // MARK: - Initializers
    init(_ viewmodel: HomeViewModel?) {
        self.homeViewModel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .weatherWhiteColor
        viewmodel.delegate = self
        setupNavigation()
        setupDayTableView()
    }
    func onCitiesChanged() {
        self.citiesTableView.reloadData()
    }
    @objc func beckTapped(_ sender: UIButton) {
        coordinator?.pop()
    }
    @objc func searchTapped(_ sender: UIButton) {
        viewmodel.getCities(for: searchView.text)
    }

    private func setupDayTableView() {
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        self.view.addSubview(citiesTableView)
        citiesTableView.register(CityCell.self, forCellReuseIdentifier: Constants.cityCellID)
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
        let backButton = createCustomButton(image: Constants.backButtonName,
                                           color: .weatherWhiteColor,
                                           selector: #selector(beckTapped))
        let searchButton = createCustomButton(image: Constants.searchButtonName,
                                              color: .weatherWhiteColor,
                                              selector: #selector(searchTapped))
        searchView.delegate = self
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = searchView
        if let height = navigationController?.navigationBar.bounds.height,
           let width = navigationController?.navigationBar.bounds.width {
            searchView.font = .systemFont(ofSize: height * 0.5, weight: .medium)
            NSLayoutConstraint.activate([
                searchView.widthAnchor.constraint(equalToConstant: width / 1.6),
                searchView.heightAnchor.constraint(equalToConstant: height * 0.7)
            ])
        }
        statusBarBackgroundColor(color: .weatherBlueColor)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityCellID, for: indexPath) as? CityCell {
            cell.configure(viewmodel.cities[indexPath.row])
            rowCell = cell
        }
        return rowCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableConstants.tableRowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeViewModel?.forecastForToday(cityName: viewmodel.cities[indexPath.row].name)
        coordinator?.pop()
    }

    private enum TableConstants {
        static let tableRowHeight: CGFloat = 40
    }
}
