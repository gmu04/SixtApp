//
//  SixtAppTests.swift
//  SixtAppTests
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import XCTest
@testable import SixtApp

class SixtAppTests: XCTestCase {
    
    var apiClient:ApiClient! = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //setup Sixt API client
        apiClient = MockSixtApiClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //clean the cache
        CacheManager.cars.removeAllObjects()
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
    }

}
