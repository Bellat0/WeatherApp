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

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()

        networkWeatherManager.fetchCurrentWeather(city: "Almaty") { currentWeather in
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

        view.addSubview(weatherIcon)
        weatherIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        weatherIcon.contentMode = .scaleAspectFill
        weatherIcon.tintColor = .white
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
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
        ) { city in
            self.networkWeatherManager.fetchCurrentWeather(city: city) { currentWeather in
                self.updateInterfae(currentWeather: currentWeather)
            }
        }
    }


    //MARK: update interface

    func updateInterfae(currentWeather: CurrentWeather) {

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
}

