//
//  Double+KelvinToCelciusString.swift
//  OpenWeather5Day
//
//  Created by Trevor Doodes on 02/12/2020.
//

import Foundation

extension Double {
    func kelvinToCelciusString() -> String {
        let celcuis = self - 273.15
        
        return String(format: "%.1f°", celcuis)
    }
}
