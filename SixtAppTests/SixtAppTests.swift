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
    
    //system under test - sut
    var sut:ViewController!
    


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    
        sut = (UIStoryboard.init(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "ViewControllerID") as! ViewController)
        
        //setup Sixt mock API client
        sut.api = MockSixtApiClient()

        //manually trigger viewDidLoad method
        _ = sut.view
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //clean the cache
        CacheManager.cars.removeAllObjects()
    }
    
    func test_tableView_exists() throws{
        XCTAssertNotNil(sut.tableview)
    }

    func test_tableView_shows_xx_cars() throws {
        let mockAPIServiceHasTwoCars = 2
        let exp = expectation(description: "API call for cars")
        
        sut.getCars { cars in
            self.sut.cars = cars
            
            //make sure expectation fullfilled in 3 seconds
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0) { err in
            print(err?.localizedDescription ?? "")
        }
        
        XCTAssertEqual(sut.cars.count, mockAPIServiceHasTwoCars)
    }

}
