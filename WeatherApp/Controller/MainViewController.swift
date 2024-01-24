//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 27.03.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Properties

    private let searchButton = UIButton(type: .system)
    private let moonButton = UIButton(type: .system)
    private let sunButton = UIButton(type: .system)

    private let temperatureLabel = UILabel()
    private let celsiusLabel = UILabel()
    private let feelsLikeTemp = UILabel()
    private let feelsLikeLabel = UILabel()

    private let weatherIcon = UIImageView()

    private let cityLabel = UILabel()
    private let descriptionWeatherType = UILabel()

    private let stackView = UIStackView()

    // MARK: - Dependencies

    var networkWeatherManager = NetworkWeatherManager()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        load(city: "Алматы")
    }

    // MARK: - Methods
    
    private func setupViews() {
        view.backgroundColor = .systemCyan

        view.addSubview(searchButton)
        view.addSubview(moonButton)
        view.addSubview(sunButton)
        view.addSubview(temperatureLabel)
        view.addSubview(celsiusLabel)
        view.addSubview(feelsLikeTemp)
        view.addSubview(feelsLikeLabel)
        view.addSubview(weatherIcon)
        view.addSubview(cityLabel)
        view.addSubview(descriptionWeatherType)
        view.addSubview(stackView)

        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)

        moonButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
        moonButton.tintColor = .white
        moonButton.addTarget(self, action: #selector(switchDarkTheme), for: .touchUpInside)

        sunButton.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        sunButton.tintColor = .white
        sunButton.addTarget(self, action: #selector(switchLightTheme), for: .touchUpInside)

        weatherIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        weatherIcon.contentMode = .scaleAspectFill
        weatherIcon.tintColor = .white

        feelsLikeLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 24)
        feelsLikeLabel.textColor = .white
        feelsLikeLabel.text = "Feels like"

        feelsLikeTemp.font = UIFont(name: "Helvetica", size: 26)
        feelsLikeTemp.textColor = .white
        feelsLikeTemp.text = "ºC"

        temperatureLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 96)
        temperatureLabel.textColor = .white
        temperatureLabel.text = "19"

        celsiusLabel.font = UIFont(name: "Helvetica", size: 32)
        celsiusLabel.textColor = .white
        celsiusLabel.text = "ºC"

        cityLabel.font = UIFont(name: "Helvetica", size: 24)
        cityLabel.textColor = .white
        cityLabel.text = "Almaty"

        descriptionWeatherType.textColor = .white
        descriptionWeatherType.font = UIFont.systemFont(ofSize: 15)
        descriptionWeatherType.text = "Cloudy"

        stackView.addArrangedSubview(moonButton)
        stackView.addArrangedSubview(sunButton)
        stackView.axis = .horizontal
        stackView.spacing = 20
    }

    private func setupConstraints() {

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }

        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(90)
            make.width.equalTo(240)
            make.height.equalTo(169)
        }

        feelsLikeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(weatherIcon.snp.top).offset(-80)
            make.leading.equalToSuperview().offset(32)
        }

        feelsLikeTemp.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeLabel).offset(-1.5)
            make.leading.equalTo(feelsLikeLabel.snp.trailing).offset(10)

        }

        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.bottom.equalTo(feelsLikeLabel).inset(20)
        }

        celsiusLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel).offset(8)
            make.leading.equalTo(temperatureLabel.snp.trailing)
        }

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(80)
            make.trailing.equalToSuperview().offset(-32)
        }

        descriptionWeatherType.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
        }
    }


    // MARK: - Update interface

    func updateInterface(currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = currentWeather.temperatureString
            self.feelsLikeTemp.text = currentWeather.feelslikeString
            self.cityLabel.text = currentWeather.cityName
            self.weatherIcon.image = UIImage(systemName: currentWeather.systemIconNameString)
            self.descriptionWeatherType.text = currentWeather.weatherType
        }
    }

    private func load(city: String) {
        networkWeatherManager.fetchCurrentWeather(city: city) { [weak self] currentWeather in
            self?.updateInterface(currentWeather: currentWeather)
        }
    }

    @objc func searchTapped() {
        presentSearchAlertController(title: "Enter the city name", message: nil) { [weak self] city in
            self?.load(city: city)
        }
    }

    // MARK: - Switch themes

    @objc func switchDarkTheme() {

        view.backgroundColor = .systemFill

        searchButton.tintColor = Colors.nightYellow
        moonButton.tintColor = Colors.nightYellow
        sunButton.tintColor = Colors.nightYellow
        temperatureLabel.textColor = Colors.nightYellow
        celsiusLabel.textColor = Colors.nightYellow
        feelsLikeTemp.textColor = Colors.nightYellow
        feelsLikeLabel.textColor = Colors.nightYellow
        weatherIcon.tintColor = Colors.nightYellow
        cityLabel.textColor = Colors.nightYellow
        descriptionWeatherType.textColor = Colors.nightYellow
    }

    @objc func switchLightTheme() {

        view.backgroundColor = .systemCyan

        searchButton.tintColor = .white
        moonButton.tintColor = .white
        sunButton.tintColor = .white
        temperatureLabel.textColor = .white
        celsiusLabel.textColor = .white
        feelsLikeTemp.textColor = .white
        feelsLikeLabel.textColor = .white
        weatherIcon.tintColor = .white
        cityLabel.textColor = .white
        descriptionWeatherType.textColor = .white
    }
}
