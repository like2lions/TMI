//
//  LocationService.swift
//  TMI
//
//  Created by 박성민 on 2023/01/13.
//

import Foundation
import CoreLocation
import MapKit
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var weatherData: WeatherData?
    
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            self.location = location
            
//            self.location?.coordinate.longitude

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Handle any errors here...
        print (error)
    }
    
    func loadCorrentWeaterData() {
        if let location {
            WeatherService
                .getWeatherData(location: location)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                            return
                    case .finished : return
                    }
                } receiveValue: { [weak self] weaterData in
                    self?.weatherData = weaterData
                }
                .store(in: &cancellables)
        }

    }
}

