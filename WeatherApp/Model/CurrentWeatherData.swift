//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 03.02.2023.
//

import Foundation

struct CurrentWeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let id: Int
    let main: String
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }

}
