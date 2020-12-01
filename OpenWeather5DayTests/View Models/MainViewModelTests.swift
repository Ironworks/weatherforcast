//
//  MainViewModelTests.swift
//  BreakingBadCharactersTests
//
//  Created by Trevor Doodes on 29/10/2020.
//

import XCTest
@testable import OpenWeather5Day

class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    var mockNetworkClient: MockNetworkClient!
    var mockViewController: MockMainViewController!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkClient = MockNetworkClient()
        mockViewController = MockMainViewController()
        sut = MainViewModel(networkClient: mockNetworkClient, viewController: mockViewController)
    }

    override func tearDownWithError() throws {
        mockNetworkClient = nil
        mockViewController = nil 
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_init_sets_network_client() {
        XCTAssertTrue(sut.networkClient is MockNetworkClient)
    }
    
    func test_init_set_mainViewController() {
        XCTAssertTrue(sut.viewController is MockMainViewController)
    }
    
    func test_can_retrieve_weather_using_network_client() {
        
        sut.retrieveWeather()
    
        XCTAssertTrue(mockNetworkClient.getWeatherCalled)
        XCTAssertTrue(self.mockViewController.reloadDataCalled)
        
    }
    
    func test_if_retrieve_fails_fire_alert_on_viewController() {
        
        mockNetworkClient.returnError = true
        
        sut.retrieveWeather()
        
        XCTAssertEqual(mockViewController.showAlertCalled, true)
        XCTAssertEqual(mockViewController.message, "The operation couldn’t be completed. (com.test.error error 0.)")
    }
}

class MockNetworkClient: NetworkClientInterface {
    
    var getWeatherCalled = false
    var returnError = false
    let error = NSError(domain: "com.test.error", code: 0, userInfo: nil)
    
    func getWeather(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        getWeatherCalled = true
        if returnError {
            completionHandler(.failure(error))
        } else {
            do {
                let data = try Data.fromJSON(fileName: "WeatherDataValid")
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}


