//
//  WeatherStore.swift
//  TMI
//
//  Created by do hee kim on 2023/01/15.
//

import Foundation
import Combine

enum HttpError: LocalizedError {
   case unknown
   case httpStatusError(Int, String)
}

class WeatherService {
    private var cancellables = Set<AnyCancellable>()
    
    func requestDataCombine<T: Codable>(type: T.Type) -> AnyPublisher<T, HttpError> {
          return URLSession.shared.dataTaskPublisher(for: createURL())
            .receive(on: DispatchQueue.main)
            .tryMap() { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("응답 오류")
                    throw HttpError.unknown
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw HttpError.httpStatusError(httpResponse.statusCode, httpResponse.description)
                }
                
                guard !data.isEmpty else {
                    throw HttpError.unknown
                }
                
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? HttpError {
                    return error
                } else {
                    return HttpError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    func createURL() -> URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "apis.data.go.kr"
        components.queryItems = [
            URLQueryItem(name: "serviceKey", value: "yo8%2FWmc7Kn5vAcqoTkGwPm3rkWuNYg%2BnFlniZvkv44rlsdJQURxVTze1WcieTQKv6oRXV77gGPUaWTWUxqya8g%3D%3D"),
            URLQueryItem(name: "dataType", value: "JSON"),
            URLQueryItem(name: "numOfRows", value: "60"),
            URLQueryItem(name: "base_date", value: currentDate()),
            URLQueryItem(name: "base_time", value: currentTime()),
            URLQueryItem(name: "nx", value: "57"),
            URLQueryItem(name: "ny", value: "22")
        ]
        return components.url!
    }
    
    func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: Date())
    }

    func currentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH00"
        return dateFormatter.string(from: Date())
    }
    
}


