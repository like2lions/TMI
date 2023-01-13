//
//  WeatherStore.swift
//  TMI
//
//  Created by tae on 2023/01/13.
//

import SwiftUI
import Combine

class WeatherStore {
    static let shared = WeatherStore()
    private init() { }
    var weather: String = "맑음"
    var cancellables = Set<AnyCancellable>()
    
    func getWeatherCombine(regionCode: String) {
        print("store get weather")
        guard let url = URL(string: "http://apis.data.go.kr/1360000/VilageFcstMsgService/getLandFcst?serviceKey=GMt2vpUCR9RRx1vj6XlA96sJew6K9xFuIpgysZi7dVu7iCK76olLJw8lxeATAk%2Bg3AqdFRQPlPtmmSxZ8B%2F5Pg%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=\(regionCode)") else { return }
        
        /// 1. sign up for monthly subscription for package to be delivered
        /// 2. the company would make the package behind the scene
        /// 3. receive the package at your front door
        /// 4. make sur the box isn't damaged
        /// 5. open and make sure the item is correct
        /// 6. use the item
        /// 7. cancellable at any time!
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into Our Type)
        // 6. sink (put the item into our app)
        URLSession.shared.dataTaskPublisher(for: url) // dataTaskPublisher가 자동적으로 2번 수행
            .subscribe(on: DispatchQueue.global(qos: .background)) // explicit하게 쓴듯?
            .receive(on: DispatchQueue.main) // 3.
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            } // TryMap is a Map that can fail and throw an error. 4.
            .decode(type: WeatherResponse.self, decoder: JSONDecoder()) // 5.
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] weatherResponse in // weak 붙이는 이유는 추가로 학습 필요
                self?.weather = (weatherResponse.response.body.items["item"]?.first!.wf)!
            }
            .store(in: &cancellables)

    }
}
