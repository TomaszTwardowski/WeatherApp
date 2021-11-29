//
//  APIError.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Filed to decode the object from the services"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "the error is unknown."
        }
    }
}
