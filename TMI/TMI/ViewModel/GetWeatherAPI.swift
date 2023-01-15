//
//  GetWeatherInfo.swift
//  TMI
//
//  Created by 김응관 on 2023/01/15.
//

import Foundation
import CoreLocation

let key = "0d268b100aab2067be1aeebe6b626058"
let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=\(key)"

extension URL {
    //도시 이름을 통해 날씨 정보를 가져오는  GET Rest API
   static func urlWith(city: String) -> URL? {
        return URL(string: "\(weatherURL)&q=\(city)")
    }
    
    //위치 값을 통해 날씨 정보를 가져오는  GET Rest API
    static func urlWith(coordinate : CLLocationCoordinate2D) -> URL? {
        let urlString = "\(weatherURL)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        print(urlString)
        return URL(string: urlString)
    }
    
}
