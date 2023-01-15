//
//  ContentView.swift
//  TMI
//
//  Created by tae on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var historyStore: HistoryStore = HistoryStore()
    @State var showWeather: Bool = false
    
    var body: some View {
        VStack {
            HomeView(showWeather: $showWeather)
        }
        .fullScreenCover(isPresented: $showWeather) {
            WeatherView(showWeather: $showWeather)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
