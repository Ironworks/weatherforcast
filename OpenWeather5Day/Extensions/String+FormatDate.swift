//
//  String+FormatDate.swift
//  OpenWeather5Day
//
//  Created by Trevor Doodes on 01/12/2020.
//

import Foundation

extension String {
    func formatDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let interimDate = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateFormat = "EEE dd/MM/yy, HH:mm"
        return dateFormatter.string(from: interimDate)
    }
}
