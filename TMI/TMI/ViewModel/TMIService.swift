//
//  WeatherService.swift
//  TMI
//
//  Created by tae on 2023/01/13.
//

import Foundation

struct TMIService {
    var weather = WeatherStore.shared
    var history = HistoryStore.shared
    
    func getWeather(regionCode: String) -> String {
        weather.getWeatherCombine(regionCode: regionCode)
        return weather.weather
    }
    
    func checkCmd(cmd: String) -> [History] {
        history.checkCmd(cmd: cmd)
        return history.histories
    }
    
}
