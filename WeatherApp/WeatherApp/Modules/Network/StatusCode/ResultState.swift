//
//  ResultState.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//

import Foundation
enum ResultState {
    case loading
    case success(content: CurrentWeather)
    case failed(error:Error)
}
