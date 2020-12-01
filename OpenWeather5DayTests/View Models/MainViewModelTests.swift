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
    
    func test_can_retrieve_characters_using_network_client() {
        
        sut.retrieveCharacters()
    
        XCTAssertEqual(mockNetworkClient.getCharactersCalled, true)
        XCTAssertEqual(self.mockViewController.model?.count, 3)
        
    }
    
    func test_if_retrieve_fails_fire_alert_on_viewController() {
        
        mockNetworkClient.returnError = true
        
        sut.retrieveCharacters()
        
        XCTAssertEqual(mockViewController.showAlertCalled, true)
        XCTAssertEqual(mockViewController.message, "The operation couldn’t be completed. (com.test.error error 0.)")
    }
    
    func test_filter_by_name_returns_correct_results() {
        
        sut.retrieveCharacters()
        
        sut.filteredContentForSearchText("Sky")
        
        XCTAssertEqual(mockViewController.model?.count, 1)
        XCTAssertEqual(mockViewController.model?[0].charId, 3)
        XCTAssertEqual(mockViewController.model?[0].name, "Skyler White")
    }
    
    
    func test_filter_by_season() {
        
        sut.retrieveCharacters()
        
        sut.filteredContentForSearchText("5", searchIndex: 1)
        
        XCTAssertEqual(mockViewController.model?.count, 2)
        XCTAssertEqual(mockViewController.model?[0].charId, 1)
        XCTAssertEqual(mockViewController.model?[0].name, "Walter White")
        XCTAssertEqual(mockViewController.model?[1].charId, 2)
        XCTAssertEqual(mockViewController.model?[1].name, "Jesse Pinkman")
    }


}

class MockNetworkClient: NetworkClientInterface {
    
    var getCharactersCalled = false
    var returnError = false

    func getCharacters(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        getCharactersCalled = true
        
        if returnError {
            let error = NSError(domain: "com.test.error", code: 0, userInfo: nil)
            completionHandler(.failure(error))
        } else {
            do {
                let data = try Data.fromJSON(fileName: "CharactersValid")
                completionHandler(.success(data))
            } catch {
                
            }
        }
    }
}


