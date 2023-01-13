//
//  WeatherRawJson.swift
//  TMI
//
//  Created by tae on 2023/01/13.
//

import Foundation

struct WeatherResponse: Codable {
    let response: WeatherRawJson
}

struct WeatherRawJson: Codable {
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
    let announceTime: Int
    let numEf: Int
    let regId: String
    let rnSt: Int
    let rnYn: Int
    let ta: String
    let wd1: String
    let wd2: String
    let wdTnd: String
    let wf: String
    let wfCd: String
    let wsIt: String
}
