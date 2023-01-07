//
//  ViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 03.01.2023.
//

import UIKit

class HomeViewController: UIViewController, HomeViewModelDelegate {
    // MARK: - Constants
    private enum Constants {
        static let mapImage = "ic_place"
        static let searchImage = "ic_my_location"
        static let dayCellID = "DayForecastCell"
        static let hourCellID = "HourForecastCell"
        static let collectionHeight: CGFloat = 80
        static let collectionSpacing: CGFloat = 15
    }

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
        viewLayout.minimumLineSpacing = Constants.collectionSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .weatherBlueLightColor
        return collectionView
    }()
    private lazy var dayTableView = UITableView()

    // MARK: - Initializers
    init(_ viewmodel: HomeViewModel, locationManager: LocationProvider) {
        self.viewmodel = viewmodel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
        self.viewmodel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        setupNavigation()
        setupCityInfoView()
        hourCollectionView.reloadData()
        dayTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.weatherBlueColor
        configureUI()
    }
    func configureUI() {
        configureLocation()
        setupNavigation()
        setupCityInfoView()
        setupHourhourCollectionViewView()
        setupDayTableView()
    }

    func onDataChanged() {
        setupNavigation()
        setupCityInfoView()
        hourCollectionView.reloadData()
        dayTableView.reloadDataSavingSelections()
    }

    @objc func mapTapped(_ sender: UIButton) {
        coordinator?.coordinateToMap()
    }
    @objc func searchTapped(_ sender: UIButton) {
        coordinator?.coordinateToSearch()
    }

    private func setupHourhourCollectionViewView() {
        hourCollectionView.delegate = self
        hourCollectionView.dataSource = self
        hourCollectionView.register(HourForecastCell.self, forCellWithReuseIdentifier: Constants.hourCellID)
        hourCollectionView.automaticallyAdjustsScrollIndicatorInsets = true
        hourCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourCollectionView.tintColor = .weatherBlueLightColor
        view.addSubview(hourCollectionView)
        NSLayoutConstraint.activate([
            hourCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hourCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hourCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hourCollectionView.heightAnchor.constraint(equalToConstant: Constants.collectionHeight)
        ])
    }

    private func setupDayTableView() {
        dayTableView.delegate = self
        dayTableView.dataSource = self
        dayTableView.register(DayForecastCell.self, forCellReuseIdentifier: Constants.dayCellID)
        dayTableView.translatesAutoresizingMaskIntoConstraints = false
        dayTableView.backgroundColor = .weatherWhiteColor
        view.addSubview(dayTableView)
        NSLayoutConstraint.activate([
            dayTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dayTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dayTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dayTableView.topAnchor.constraint(equalTo: hourCollectionView.bottomAnchor)
        ])
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

    func setupCityInfoView() {
        cityInfoView.setup(cityMain: viewmodel.currentCityMain)
        view.addSubview(cityInfoView)
        NSLayoutConstraint.activate([
            cityInfoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cityInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            cityInfoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            cityInfoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func configureLocation() {
        viewmodel.autorizeCitiesApi()
        locationManager.requestAuthorization()
        if let location = locationManager.currentUserLocation {
            //showActivityIndicator()
            viewmodel.forecastForToday(location.coordinate.latitude,
                                       location.coordinate.longitude)
        }
    }

//    // MARK - Spinner
//    // todo move to seperate class / extension
//    var activityView: UIActivityIndicatorView?
//    func showActivityIndicator() {
//        activityView = UIActivityIndicatorView(style: .large)
//        activityView?.center = self.view.center
//        self.view.addSubview(activityView!)
//        activityView?.startAnimating()
//    }
//
//    func hideActivityIndicator() {
//        if (activityView != nil) {
//            activityView?.stopAnimating()
//        }
//    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.listOfDayForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowCell = UITableViewCell()
        rowCell.selectionStyle = .none
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.dayCellID, for: indexPath) as? DayForecastCell {
            cell.configure(viewmodel.listOfDayForecast[indexPath.row])
            rowCell = cell
        }
        return rowCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableConstant.itemHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewmodel.currentCityMain = viewmodel.listOfDayForecast[indexPath.row]
    }

    private enum TableConstant {
        static let itemHeight: CGFloat = 60
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.listOfHourForecast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var rowCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.hourCellID, for: indexPath) as? HourForecastCell {
            cell.configure(viewmodel.listOfHourForecast[indexPath.row])
            rowCell = cell
        }
        return rowCell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.collectionHeight * 0.5, height: Constants.collectionHeight)
    }
}
