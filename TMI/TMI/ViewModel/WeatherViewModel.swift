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

class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    
    public let locationManager = CLLocationManager()
    private var compltionHandler: ((Forecast) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func loadWeatherData(_ completionHandler: @escaping((Forecast) -> Void)) {
        self.compltionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherForecast(forCoordinates coordinates: CLLocationCoordinate2D) {
        let apiService = WeatherService.shared
        apiService.getJson(urlString: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=7abc782c5f925882bf8b79a106ecf88e&units=metric") { (result: Result<Forecast, WeatherService.APIError>) in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.cityName = forecast.name
                    self.weatherIcon = forecast.weather[0].icon
                    self.temperature = "\(forecast.main.temp)°"
                    self.weatherDescription = forecast.weather[0].main
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

extension WeatherViewModel: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        getWeatherForecast(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치정보 받아오기 실패: \(error.localizedDescription)")
    }
}
