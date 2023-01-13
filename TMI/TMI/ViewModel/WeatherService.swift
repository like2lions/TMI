//
//  WeatherService.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation
import CoreLocation

final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "7abc782c5f925882bf8b79a106ecf88e"
    private var compltionHandler: ((Weather) -> Void)?
    
    func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.compltionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.compltionHandler?(Weather(response: response))
            }
        }
        .resume()
    }
}

//struct APIResponse {
//    let name: String
//    let main: APIMain
//    let weather: [APIWeather]
//}

//struct APIMain: Decodable {
//    let temp: Double
//}

//struct APIWeather: Decodable {
//    let description: String
//    let iconName: String
//    
//    enum CodingKeys: String, CodingKey {
//        case description
//        case iconName = "main"
//    }
//}
