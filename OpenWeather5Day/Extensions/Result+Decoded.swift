//
//  Result+Decoded.swift
//   OpenWeather5Day
//
//  Created by Trevor Doodes on 29/11/2020.
//

import Foundation

extension Result where Success == Data {
    func decoded<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}
