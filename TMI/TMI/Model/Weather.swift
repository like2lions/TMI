//
//  Weather.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import Foundation

struct Forecast: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let dt: Date
    let id: Int
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
}
