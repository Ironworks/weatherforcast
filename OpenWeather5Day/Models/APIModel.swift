//
//  APIModel.swift
//  OpenWeather5Day
//
//  Created by Trevor Doodes on 29/11/2020.
//

import Foundation

struct APIModel: Codable {
    let cod: String
    let list: [WeatherObject]
    let city: City
}

struct WeatherObject: Codable {
    let date: Int
    let dateText: String
    let main: Main
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case dateText = "dt_txt"
        case main
        case weather
    }
    
}

struct Main: Codable {
    let temp: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

struct Weather: Codable {
    let description: String
}

struct City: Codable {
    let name: String
    let country: String
}
