//
//  Weather.swift
//  TMI
//
//  Created by 김응관 on 2023/01/15.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable, Hashable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}


// MARK: - Clouds
struct Clouds: Codable, Hashable  {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable, Hashable  {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable, Hashable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct Rain: Codable, Hashable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Sys
struct Sys: Codable, Hashable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable, Hashable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double
}
