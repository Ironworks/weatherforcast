//
//  NetworkClient.swift
//  OpenWeather5Day
//
//  Created by Trevor Doodes on 29/11/2020.
//

import Foundation

protocol NetworkClientInterface {
    func getWeather(completionHandler: @escaping (Result<Data, Error>) -> Void)
}

class NetworkClient: NetworkClientInterface {
    
    let baseURL: URL
    let session: URLResultSession
    
    init(baseURL: URL, session: URLResultSession) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func getWeather(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: "data/2.5/forecast?q=london&appid=f1a57ebfd31877b191395e4e808d56c6", relativeTo: baseURL) else {return}
        let task = session.dataTask(with: url) { result in
            switch result {
            case .success((_, let data)):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
