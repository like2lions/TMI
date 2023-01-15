//
//  WeatherTestView.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import SwiftUI

struct WeatherTestView: View {
    
    @ObservedObject var weatherViewModel: WeatherViewModel = WeatherViewModel(weatherService: WeatherService())
    
    var body: some View {
        
        HStack(spacing: 2) {
            Text(weatherViewModel.cityName)
            Text(weatherViewModel.temperature)
            Image(systemName: weatherViewModel.weatherIcon)
            Text(weatherViewModel.weatherDescription)
        }
        .onAppear {
            weatherViewModel.refresh()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTestView(weatherViewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
