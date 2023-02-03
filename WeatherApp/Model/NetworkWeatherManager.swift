//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 03.02.2023.
//

import Foundation

class NetworkWeatherManager {
     func fetchCurrentWeather(city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            self.parseJSON(data: data)
        }.resume()
    }
    
    func parseJSON(data: Data) {
        do {
            let currentWeather = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
            print(currentWeather)
        } catch {
            print("Error!")
        }
    }
}
