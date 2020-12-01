//
//  MockMainViewController.swift
//   OpenWeather5DayTests
//
//  Created by Trevor Doodes on 29/11/2020.
//

import Foundation
@testable import OpenWeather5Day

class MockMainViewController: MainViewProtocol {
    var reloadDataCalled = false
    var showAlertCalled = false
    var message = ""
    
    var model: APIModel? {
        didSet {
            reloadData()
        }
    }
    
    func reloadData() {
        reloadDataCalled = true
    }
    
    func showAlert(message: String) {
        showAlertCalled = true
        self.message = message
    }
    
}
