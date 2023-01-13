//
//  APIResponse.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}
