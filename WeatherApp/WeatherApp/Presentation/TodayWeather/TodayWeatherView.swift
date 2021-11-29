//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//

import SwiftUI

struct TodayWeatherView: View {
    #warning("this is on for display view")
    @StateObject var viewModel = TodayWeatherViewModel(service: CurrentWeatherServices(), city: "Warszawa")
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .success(let data):
                Text("City: \(data.name)")
                    .padding()
                Text("Description: \(data.weather.first!.weatherDescription)")
                    .padding()
                Text("Location: \n Latitude:\(data.coord.lat)\n Longitude:\(data.coord.lon)")
                    .padding()
                Text("Main info: \(data.weather.first!.main)")
                    .padding()
                Text("Icon: \(data.weather.first!.icon)")
                    .padding()
                Text("Temp: \(data.main.temp) K")
                    .padding()
                Text("Country: \(data.sys.country)")
                    .padding()
            case .loading:
                ProgressView()
            case .failed(error: let error):
                Text(error.localizedDescription)
                    .padding()
            }
           
        }.onAppear(perform: viewModel.getWeather)
    }
    
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView()
    }
}
