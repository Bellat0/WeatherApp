//
//  AlertControllerVC.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 03.02.2023.
//

import UIKit

extension ViewController {
    
    func presentSearchAlertController(title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField() { tf in
            let cities = ["Almaty", "Astana", "Moscow", "Berlin", "Paris"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let text = textField?.text else { return }
            if text != "" {
                
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}
