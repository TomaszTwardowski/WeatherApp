//
//  CurrentWeatherService.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//

import Foundation
import Combine

protocol CurrentWeatherServicesProtocol {
    func request(from endpoint: OpenWeatherAPI) -> AnyPublisher<CurrentWeather, APIError>
}

struct CurrentWeatherServices: CurrentWeatherServicesProtocol {
    
    
    func request(from endpoint: OpenWeatherAPI) -> AnyPublisher<CurrentWeather, APIError> {
        URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest!)
            .receive(on:DispatchQueue.main)
            .mapError{ _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<CurrentWeather, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                #warning("TO DO add enum for statusCode")
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: CurrentWeather.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
