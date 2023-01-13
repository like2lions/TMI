//
//  WeatherViewModel.swift
//  TMI
//
//  Created by tae on 2023/01/13.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var histories: [History] = []
    @Published var loc: Region = .Seoul
    @Published var setLocOn: Bool = false
    @Published var weather: String = ""
    var tmiService: TMIService = TMIService()
    var regionCode: String  {
        tmiService.history.getRegionCode(region: loc)
    }
    
    init() {
        
    }
    func getWeather() {
        print("view model get weather")
        weather = tmiService.getWeather(regionCode: regionCode)
    }
    
    func checkCmd(cmd: String) {
        print("view model check cmd")
        histories = tmiService.checkCmd(cmd: cmd)
    }
 
}
