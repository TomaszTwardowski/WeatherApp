//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//

import Foundation

protocol APIBuilderProtocol {
    var urlRequest: URLRequest? { get }
    var baseUrl: String { get }
    var path: String { get }
    var apiKey: String { get }
    var sortElement: String { get }
}

enum OpenWeatherAPI {
    case getWeatherByCity(String)
}

extension OpenWeatherAPI: APIBuilderProtocol {
    
    
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.baseUrl
        urlComponents.path = BasePath.path + self.path
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "q", value: sortElement)
        ]
        if let url = urlComponents.url {
            return URLRequest(url: url)
        } else {
            #warning("TO DO add error")
            return nil
        }
    }
    
    var baseUrl: String {
        return BaseUrl.url
    }
    
    var path: String {
        switch self {
        case .getWeatherByCity(_):
            return "/weather"
        }
    }
    
    var sortElement: String {
        switch self {
        case .getWeatherByCity(let city):
            return city
        }
    }
    
    var apiKey: String {
        APIKey.key
    }
}
