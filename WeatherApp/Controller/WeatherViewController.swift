//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 27.03.2023.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {

    let networkWeatherManager = NetworkWeatherManager()

    private let searchButton = UIButton(type: .system)
    private let temperatureLabel = UILabel()
    private let celsiusLabel = UILabel()
    private let feelsLikeTemp = UILabel()
    private let feelsLikeLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let cityLabel = UILabel()
    private let descriptionWeatherType = UILabel()

    private let moonButton = UIButton(type: .system)
    private let sunButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()

        networkWeatherManager.fetchCurrentWeather(city: "Almaty") { [unowned self] currentWeather in
            self.updateInterfae(currentWeather: currentWeather)
        }
    }

    //MARK: layout UI

    private func layoutUI() {
        view.backgroundColor = .systemCyan

        view.addSubview(searchButton)
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        searchButton.tintColor = .white
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.centerX.equalToSuperview()
        }
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)

        view.addSubview(moonButton)
        moonButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
        moonButton.tintColor = .white
        moonButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(45)
            make.centerX.equalTo(searchButton).offset(-25)
        }
        moonButton.addTarget(self, action: #selector(switchDarkTheme), for: .touchUpInside)

        view.addSubview(sunButton)
        sunButton.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        sunButton.tintColor = .white
        sunButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(45)
            make.leading.equalTo(moonButton.snp.trailing).offset(25)
        }
        sunButton.addTarget(self, action: #selector(switcLightTheme), for: .touchUpInside)

        view.addSubview(weatherIcon)
        weatherIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        weatherIcon.contentMode = .scaleAspectFill
        weatherIcon.tintColor = .white
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(90)
            make.width.equalTo(240)
            make.height.equalTo(169)
        }

        view.addSubview(feelsLikeLabel)
        feelsLikeLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 24)
        feelsLikeLabel.textColor = .white
        feelsLikeLabel.text = "Feels like"
        feelsLikeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(weatherIcon.snp.top).offset(-80)
            make.leading.equalToSuperview().offset(32)
        }

        view.addSubview(feelsLikeTemp)
        feelsLikeTemp.font = UIFont(name: "Helvetica", size: 26)
        feelsLikeTemp.textColor = .white
        feelsLikeTemp.text = "ºC"
        feelsLikeTemp.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeLabel).offset(-1.5)
            make.leading.equalTo(feelsLikeLabel.snp.trailing).offset(10)

        }

        view.addSubview(temperatureLabel)
        temperatureLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 96)
        temperatureLabel.textColor = .white
        temperatureLabel.text = "19"
        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.bottom.equalTo(feelsLikeLabel).inset(20)
        }

        view.addSubview(celsiusLabel)
        celsiusLabel.font = UIFont(name: "Helvetica", size: 32)
        celsiusLabel.textColor = .white
        celsiusLabel.text = "ºC"
        celsiusLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel).offset(8)
            make.leading.equalTo(temperatureLabel.snp.trailing)
        }

        view.addSubview(cityLabel)
        cityLabel.font = UIFont(name: "Helvetica", size: 24)
        cityLabel.textColor = .white
        cityLabel.text = "Almaty"
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(80)
            make.trailing.equalToSuperview().offset(-32)
        }

        view.addSubview(descriptionWeatherType)
        descriptionWeatherType.textColor = .white
        descriptionWeatherType.font = UIFont.systemFont(ofSize: 15)
        descriptionWeatherType.text = "Cloudy"
        descriptionWeatherType.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
        }
    }

    //MARK: add action for button

    @objc func searchTapped() {

        presentSearchAlertController(
            title: "Enter the city name",
            message: nil, style: .alert
        ) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(city: city) { currentWeather in
                self.updateInterfae(currentWeather: currentWeather)
            }
        }
    }


    //MARK: update interface

    private func updateInterfae(currentWeather: CurrentWeather) {

        DispatchQueue.main.async {
            self.temperatureLabel.text = currentWeather.temperatureString
            self.feelsLikeTemp.text = currentWeather.feelslikeString
            self.cityLabel.text = currentWeather.cityName
            self.weatherIcon.image = UIImage(systemName: currentWeather.systemIconNameString)
            self.descriptionWeatherType.text = currentWeather.weatherType
        }
    }

    //MARK: work with Alert Controller

    private func presentSearchAlertController(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        completion: @escaping (String)->()
    ) {

        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField() { tf in
            let cities = ["Almaty", "Astana", "Moscow", "Berlin", "Paris"]
            tf.placeholder = cities.randomElement()
        }

        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completion(city)
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true)
    }

    //MARK: Switch dark and light Theme

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

    @objc func switcLightTheme() {
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

    //MARK: Enum Colors
    public enum Colors {
        static let nightYellow = UIColor(
            red: 243/255,
            green: 255/255,
            blue: 135/255,
            alpha: 1)
    }
}

