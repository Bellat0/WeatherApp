//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 03.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalize()
        presentSearchAlertController(title: "Enter the city name", message: nil, style: .alert)
        networkWeatherManager.fetchCurrentWeather(city: "Almaty")
    }

    private func initalize() {
        
        view.backgroundColor = .systemCyan
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        searchButton.tintColor = .white
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.centerX.equalToSuperview()
        }
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        let temperatureLabel = UILabel()
        temperatureLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 96)
        temperatureLabel.textColor = .white
        temperatureLabel.text = "19"
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.equalTo(searchButton).inset(39)
        }
        
        let celsiusLabel = UILabel()
        celsiusLabel.font = UIFont(name: "Helvetica", size: 32)
        celsiusLabel.textColor = .white
        celsiusLabel.text = "ºC"
        view.addSubview(celsiusLabel)
        celsiusLabel.snp.makeConstraints { make in
            make.top.equalTo(searchButton).inset(52)
            make.leading.equalTo(temperatureLabel).inset(90)
        }

        let feelsLikeLabel = UILabel()
        feelsLikeLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 24)
        feelsLikeLabel.textColor = .white
        feelsLikeLabel.text = "Feels like"
        view.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel).inset(100)
            make.leading.equalToSuperview().inset(32)
        }

        let feelsLikeTemp = UILabel()
        feelsLikeTemp.font = UIFont(name: "Helvetica", size: 24)
        feelsLikeTemp.textColor = .white
        feelsLikeTemp.text = "19ºC"
        view.addSubview(feelsLikeTemp)
        feelsLikeTemp.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel).inset(100)
            make.leading.equalTo(feelsLikeLabel).inset(100)
        }
        
        let weatherIcon = UIImageView()
        weatherIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        weatherIcon.tintColor = .white
        view.addSubview(weatherIcon)
        weatherIcon.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(240)
        }
        
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "Helvetica", size: 32)
        cityLabel.textColor = .white
        cityLabel.text = "Almaty"
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon).inset(320)
            make.trailing.equalToSuperview().inset(32)
        }
    }
    
    @objc func searchTapped() {
        presentSearchAlertController(title: "Enter the city name", message: nil, style: .alert)
    }
}

