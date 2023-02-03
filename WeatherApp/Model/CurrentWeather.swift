//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 03.02.2023.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
    var temperatureString: String {
        return "\(temperature)"
    }
    
    let feelslike: Double
    var feelslikeString: String {
        return "\(feelslike)"
    }
    
    let cityName: String
    
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData) {
        temperature = currentWeatherData.main.temp
        feelslike = currentWeatherData.main.feelsLike
        cityName = currentWeatherData.name
        conditionCode = currentWeatherData.weather.first!.id
    }
}
