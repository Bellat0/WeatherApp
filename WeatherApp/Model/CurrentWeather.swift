//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 27.03.2023.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }

    let feelslike: Double
    var feelslikeString: String {
        return String(format: "%.0f", temperature) + "ºC"
    }

    let cityName: String
    let weatherType: String

    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {

        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "nosign"
        }
    }

    init?(currentWeatherData: CurrentWeatherData) {
        temperature = currentWeatherData.main.temp
        feelslike = currentWeatherData.main.feelsLike
        cityName = currentWeatherData.name
        conditionCode = currentWeatherData.weather.first!.id
        weatherType = currentWeatherData.weather.first!.main
    }
}
