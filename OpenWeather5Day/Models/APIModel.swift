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
    let dateText: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Int
    let minTem: Int
    let maxTemp: Int
}

struct Weather: Codable {
    let description: String
}

struct City: Codable {
    let name: String
    let country: String
}
