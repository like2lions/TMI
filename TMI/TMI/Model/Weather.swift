//
//  Weather.swift
//  TMI
//
//  Created by do hee kim on 2023/01/15.
//

import Foundation

struct WeatherAPI: Codable, Hashable {
    var response: Response
}

struct Response: Codable, Hashable {
    var header: Header
    var body: Body
}

struct Header: Codable, Hashable {
    var resultCode: String
    var resultMsg: String
}

struct Body: Codable, Hashable {
    var dataType: String
    var items: Items
}

struct Items: Codable, Hashable {
    var item: [Weather]
}

struct Weather: Codable, Hashable {
    var baseDate: String
    var baseTime: String
    var category: String
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
    var nx: Int
    var ny: Int
}
