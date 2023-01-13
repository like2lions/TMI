//
//  WeatherViewModel.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation

private let defaultIcon = "sparkles"
private let iconMap = [
    "Drizzle": "cloud.drizzle",
    "Thunderstorm": "cloud.bolt",
    "Rain": "cloud.heavyrain",
    "Snow": "snowflake",
    "Clear": "sun.max",
    "Clouds": "smoke"
]

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    
    let weatherService: WeatherService
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}
