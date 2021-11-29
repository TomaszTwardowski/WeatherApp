//
//  TodayWeatherViewModel.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//

import Foundation
import Combine
import UIKit

protocol TodayWeatherViewModelProtocol {
    func getWeather()
}

class TodayWeatherViewModel: ObservableObject, TodayWeatherViewModelProtocol {
    
    private let service: CurrentWeatherServices
    
    private(set) var weather : CurrentWeather?
    private var cancelable = Set<AnyCancellable>()
    private(set) var city: String
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: CurrentWeatherServices, city: String) {
        self.service = service
        self.city = city
    }
    
    func getWeather() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getWeatherByCity(city))
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.weather!)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.weather = response
            }
        self.cancelable.insert(cancellable)
    }
}
