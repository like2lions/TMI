//
//  WeatherService.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation
import CoreLocation
import Combine

public final class WeatherService {
    
    public static let shared = WeatherService()
    var cancellable = Set<AnyCancellable>()
    enum APIError: Error {
        case error(_ errorString: String)
    }
    
    func getJson<T: Decodable>(urlString: String,
                               dateDecodingStarategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStarategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .sink { taskCompletion in
                switch taskCompletion {
                case .finished:
                    return
                case .failure(let decodingError):
                    completion(.failure(APIError.error("Erro: \(decodingError.localizedDescription)")))
                }
            } receiveValue: { decodeData in
                completion(.success(decodeData))
            }
            .store(in: &cancellable)
    }
}
