//
//  AlertController.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 09.07.2023.
//

import UIKit

extension MainViewController {

    // MARK: - Create Alert Controller

    func presentSearchAlertController(
        title: String?,
        message: String?,
        completion: @escaping (String) -> ()
    ) {

        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
