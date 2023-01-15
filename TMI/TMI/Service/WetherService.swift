//
//  WetherService.swift
//  TMI
//
//  Created by 박성민 on 2023/01/13.
//

import Foundation
import Combine
import CoreLocation


struct WeatherService {
    var weather: String = "맑음"

    static func getWeatherData(location: CLLocation) -> AnyPublisher<WeatherData, Error> {
        
        var dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyyMMdd"
        var currentDateString = dayFormatter.string(from: Date())
        
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH"
        var currentTimeString = timeFormatter.string(from: Date())
        
        let encodingKey = "FwH8d3fqaEKb2XRuga%2F%2BhQsRDLQtmr32aaEtQydvDVd2CEnJTyNjKBTwGxzwtymSqGkwn%2FKXS2CccmI1lR10ww%3D%3D"
        let url = URL(string: " https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=\(encodingKey)&numOfRows=10&pageNo=1&base_date=\(currentDateString)&base_time=\(currentTimeString)00&nx=\(location.coordinate.latitude)&ny=\(location.coordinate.longitude)&dataType=JSON")!
            
            return URLSession.shared
                .dataTaskPublisher(for: url)
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: WeatherData.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
    }
}


