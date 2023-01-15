//
//  WeatherView.swift
//  TMI
//
//  Created by 김응관 on 2023/01/15.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @Binding var showWeather: Bool
    @State var goBack: String = ""
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        VStack {
            TextField("", text: $goBack)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if goBack == ":wq" {
                        showWeather.toggle()
                    }
                }
            Text("\(coordinate.longitude), \(coordinate.latitude)")
        }
        .onAppear {
            locationManager.checkIfLocationServiceIsEnabled()
            URL.urlWith(coordinate: coordinate)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(showWeather: .constant(false))
    }
}
