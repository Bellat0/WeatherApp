//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 27.03.2023.
//

import Foundation

class NetworkWeatherManager {

    func fetchCurrentWeather(city: String, completion: @escaping (CurrentWeather)->()) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=ru"
        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let currentWeather = self.parseJSON(data: data) else { return }
            completion(currentWeather)
        }.resume()
    }

    func parseJSON(data: Data) -> CurrentWeather? {
        do {
            let currentWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(
                currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch {
            print("Error!")
        }
        return nil
    }
}
