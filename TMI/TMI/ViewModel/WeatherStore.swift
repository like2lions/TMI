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
    
    var url = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?"
    let serviceKey = "yo8%2FWmc7Kn5vAcqoTkGwPm3rkWuNYg%2BnFlniZvkv44rlsdJQURxVTze1WcieTQKv6oRXV77gGPUaWTWUxqya8g%3D%3D"
    let dataType = "JSON"
    let numOfRows = "60"
    var base_date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: Date())
    }
    var base_time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH00"
        return dateFormatter.string(from: Date())
    }
    var nx: String?
    var ny: String?
    
    func requestDataCombine<T: Codable>(type: T.Type) -> AnyPublisher<T, HttpError> {
          return URLSession.shared.dataTaskPublisher(for: URL(string: self.url)!)
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
}


