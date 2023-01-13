//
//  WeatherView.swift
//  TMI
//
//  Created by zooey on 2023/01/13.
//

import SwiftUI

struct WeatherView: View {
    
    var body: some View {
        HStack {
           Text("천왕동")
            Text("25°")
            Image(systemName: "sun.max")
            Text("clear")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
