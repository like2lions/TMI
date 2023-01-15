//
//  WeatherView.swift
//  TMI
//
//  Created by 김응관 on 2023/01/15.
//

import SwiftUI

struct WeatherView: View {
    @Binding var showWeather: Bool
    @State var goBack: String = ""
    
    var body: some View {
        TextField("", text: $goBack)
            .textFieldStyle(.roundedBorder)
            .onSubmit {
                if goBack == ":wq" {
                    showWeather.toggle()
                }
            }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(showWeather: .constant(false))
    }
}
