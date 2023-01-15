//
//  WeatherViewModel.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation
import CoreLocation
import SwiftUI

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
    
    @Published var forecast: [Forecast] = []
    
    @Published var location: String = ""
    
    func getWeatherForecast() {
        let apiService = WeatherService.shared
        CLGeocoder().geocodeAddressString(location) { placemarks, error in
            if let error = error as? CLError {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                apiService.getJson(urlString: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=7abc782c5f925882bf8b79a106ecf88e&units=metric&lang=kr", dateDecodingStarategy: .secondsSince1970) { (result: Result<Forecast, WeatherService.APIError>) in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.cityName = forecast.name
                            self.weatherIcon = forecast.weather[0].icon
                            self.temperature = "\(forecast.main.temp)°"
                            self.weatherDescription = forecast.weather[0].description
//                            self.forecast.append(forecast)
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            }
        }
    }
}
