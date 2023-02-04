//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 03.02.2023.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    let networkWeatherManager = NetworkWeatherManager()
    
    let temperatureLabel = UILabel()
    let feelsLikeTemp = UILabel()
    let cityLabel = UILabel()
    let weatherIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.initalize()
        }
        networkWeatherManager.fetchCurrentWeather(city: "Almaty") { [self] currentWeather in
            updateInterfae(currentWeather: currentWeather)
        }
    }
    
    
    @objc func searchTapped() {
        presentSearchAlertController(title: "Enter the city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(city: city) { currentWeather in
                self.updateInterfae(currentWeather: currentWeather)
            }
        }
    }
    
    func updateInterfae(currentWeather: CurrentWeather) {
        DispatchQueue.main.async { [self] in
            temperatureLabel.text = currentWeather.temperatureString
            feelsLikeTemp.text = currentWeather.feelslikeString
            cityLabel.text = currentWeather.cityName
            weatherIcon.image = UIImage(systemName: currentWeather.systemIconNameString)
        }
    }
}

