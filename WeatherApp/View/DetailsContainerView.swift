//
//  DetailscontainerView.swift
//  WeatherApp
//
//  Created by Maxim Tvilinev on 04.02.2023.
//

import UIKit

extension DetailsViewController {
    
    
    
    func initalize() {
        
        view.backgroundColor = .systemCyan
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        searchButton.tintColor = .white
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.centerX.equalToSuperview()
        }
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        
        temperatureLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 96)
        temperatureLabel.textColor = .white
        temperatureLabel.text = "19"
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.top.equalTo(searchButton).inset(100)
        }
        
        let celsiusLabel = UILabel()
        celsiusLabel.font = UIFont(name: "Helvetica", size: 32)
        celsiusLabel.textColor = .white
        celsiusLabel.text = "ºC"
        view.addSubview(celsiusLabel)
        celsiusLabel.snp.makeConstraints { make in
            make.top.equalTo(searchButton).inset(110)
            make.leading.equalTo(temperatureLabel.snp.trailing)
        }
        
        let feelsLikeLabel = UILabel()
        feelsLikeLabel.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 24)
        feelsLikeLabel.textColor = .white
        feelsLikeLabel.text = "Feels like"
        view.addSubview(feelsLikeLabel)
        feelsLikeLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.leading.equalToSuperview().inset(32)
        }
        
        feelsLikeTemp.font = UIFont(name: "Helvetica", size: 24)
        feelsLikeTemp.textColor = .white
        feelsLikeTemp.text = "19ºC"
        view.addSubview(feelsLikeTemp)
        feelsLikeTemp.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.leading.equalTo(feelsLikeLabel).inset(100)
        }
        
        weatherIcon.image = UIImage(systemName: "cloud.drizzle.fill")
        weatherIcon.contentMode = .scaleAspectFill
        weatherIcon.tintColor = .white
        view.addSubview(weatherIcon)
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(feelsLikeLabel).inset(100)
            make.width.equalTo(240)
            make.height.equalTo(169)
        }
        
        cityLabel.font = UIFont(name: "Helvetica", size: 24)
        cityLabel.textColor = .white
        cityLabel.text = "Almaty"
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon).inset(250)
            make.trailing.equalToSuperview().inset(32)
        }
        
        let authorLabel = UILabel()
        authorLabel.font = UIFont(name: "Helvetica", size: 12)
        authorLabel.textColor = .white
        authorLabel.text = "Designed by Maxim Tvilinev"
        view.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
        
    }
}


