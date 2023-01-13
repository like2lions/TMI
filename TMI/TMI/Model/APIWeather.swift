//
//  APIWeather.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
