//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Tomasz Twardowski on 24/11/2021.
//
// I used auto generate struct base on JSON response https://app.quicktype.io

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}


extension CurrentWeather {
    
    static var dummyData = CurrentWeather(coord: Coord(lon: 18.6464,
                                                       lat: 54.3521),
                                          weather: [
                                            Weather(id: 803,
                                                    main: "Clouds",
                                                    weatherDescription: "broken clouds",
                                                    icon: "04d")
                                                   ],
                                          base: "stations",
                                          main: Main(temp: 281.18,
                                                     feelsLike: 277.83,
                                                     tempMin: 281.57,
                                                     tempMax: 281.57,
                                                     pressure: 1018,
                                                     humidity: 90,
                                                    seaLevel: 993,
                                                     grndLevel: 979),
                                          visibility: 10000,
                                          wind: Wind(speed: 6.17,
                                                     deg: 270, gust: 12.35),
                                          clouds: Clouds(all: 75),
                                          dt: 1637754482,
                                          sys: Sys(country: "PL",
                                                   sunrise: 1637735489,
                                                   sunset: 1637764388),
                                          timezone: 3600,
                                          id: 3099434,
                                          name: "Gdańsk",
                                          cod: 200)
}
