//
//  WeatherData.swift
//  TMI
//
//  Created by 박성민 on 2023/01/13.
//

import Foundation


struct WeatherData: Codable {
    let response: WeatherJsonData
}

struct WeatherJsonData: Codable {
    let header: WeatherHeader
    let body: WeatherBody

}

struct WeatherHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

struct WeatherBody: Codable {
    let dataType: String
    let items: [String : [Weather]]
    let pageNo: Int
    let numOfRows: Int
    let totalCount: Int
}

struct Weather: Codable {
    let baseDate: String
    let baseTime: String
    let category: String
    let fcstDate: String
    let fcstTime: String
    let fcstValue: String
    let nx: String
    let ny: String
}
