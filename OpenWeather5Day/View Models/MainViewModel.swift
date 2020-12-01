//
//  MainViewModel.swift
//  OpenWeather5Day
//
//  Created by Trevor Doodes on 29/11/2020.
//

protocol MainViewProtocol: class {
    var model: APIModel? { get set }
    
    func showAlert(message: String)
}

import Foundation

protocol MainViewModelInterface {
    func retrieveWeather()
}

class MainViewModel: MainViewModelInterface {
    
    var networkClient: NetworkClientInterface
    var model: APIModel?
    weak var viewController: MainViewProtocol?
    
    init(networkClient: NetworkClientInterface, viewController: MainViewProtocol) {
        self.networkClient = networkClient
        self.viewController = viewController
    }
    
    func retrieveWeather() {
        networkClient.getWeather() { result in
            do {
                let weather = try result.decoded() as APIModel
                self.model = weather
                self.viewController?.model = weather
            } catch let error {
                self.viewController?.showAlert(message: error.localizedDescription)
            }
        }
    }
        
}
