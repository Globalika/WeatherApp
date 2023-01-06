//
//  ViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class HomeViewController: UIViewController, HomeViewModelDelegate {
    // MARK: - Properties
    var viewmodel: HomeViewModel
    var locationManager: LocationProvider
    var coordinator: HomeFlow?
    var cityInfoView: CityInfoView = {
        var view = CityInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let hourCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .weatherBlueLightColor
        return collectionView
    }()
    private lazy var dayTableView = UITableView()
    init(_ viewmodel: HomeViewModel, locationManager: LocationProvider) {
        self.viewmodel = viewmodel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
        viewmodel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    func onDataChanged() {
        configure()
    }
    func onHourDataChanged() {
        hourCollectionView.reloadData()
    }
    func onDayDataChanged() {
        dayTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.weatherBlueColor
        configureLocation()
        setupHourhourCollectionViewView()
        setupDayTableView()
        configure()
    }
    private func setupHourhourCollectionViewView() {
        hourCollectionView.delegate = self
        hourCollectionView.dataSource = self
        hourCollectionView.register(HourForecastCell.self, forCellWithReuseIdentifier: "HourForecastCell")
        hourCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourCollectionView.tintColor = .weatherBlueLightColor
        view.addSubview(hourCollectionView)
        NSLayoutConstraint.activate([
            hourCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hourCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hourCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    private func setupDayTableView() {
        dayTableView.delegate = self
        dayTableView.dataSource = self
        dayTableView.register(DayForecastCell.self, forCellReuseIdentifier: "DayForecastCell")
        dayTableView.translatesAutoresizingMaskIntoConstraints = false
        dayTableView.backgroundColor = .weatherBlueColor
        view.addSubview(dayTableView)
        NSLayoutConstraint.activate([
            dayTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dayTableView.topAnchor.constraint(equalTo: hourCollectionView.bottomAnchor)
        ])
    }
    func configure() {
        setupNavigation()
        setupCityInfoView()
    }
    func setupNavigation() {
        createCustomNavigationBar(color: .weatherBlueColor)
        let mapButton = createCustomButton(image: Constants.mapImage,
                                           title: viewmodel.cityName,
                                           color: .weatherWhiteColor,
                                           selector: #selector(mapTapped))
        let searchButton = createCustomButton(image: Constants.searchImage,
                                              color: .weatherWhiteColor,
                                              selector: #selector(searchTapped))
        navigationItem.leftBarButtonItem = mapButton
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.backgroundColor = .weatherBlueColor
    }
    @objc func mapTapped(_ sender: UIButton) {
        coordinator?.coordinateToMap()
    }
    @objc func searchTapped(_ sender: UIButton) {
        coordinator?.coordinateToSearch()
    }
    func setupCityInfoView() {
        cityInfoView.setup(cityMain: viewmodel.currentCityMain)
        view.addSubview(cityInfoView)
        NSLayoutConstraint.activate([
            cityInfoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cityInfoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            cityInfoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            cityInfoView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
        ])
    }
    func configureLocation() {
        viewmodel.autorizeCitiesApi()
        locationManager.requestAuthorization()
        if let location = locationManager.currentUserLocation {
            viewmodel.forecastForToday(location: location)
        }
    }
    enum Constants {
        static let mapImage = "ic_place"
        static let searchImage = "ic_my_location"
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.listOfDayForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DayForecastCell", for: indexPath) as? DayForecastCell {
            cell.configure(viewmodel.currentCityMain)
            rowCell = cell
        }
        return rowCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.listOfHourForecast.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var rowCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourForecastCell", for: indexPath) as? HourForecastCell {
            cell.configure(viewmodel.currentCityMain)
            rowCell = cell
        }
        return rowCell
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: 0)

        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return finalWidth - 5.0
    }
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 100.0
    }
}
