//
//  APIServiceTests.swift
//  SixtAppTests
//
//  Created by Gokhan Mutlu on 6.07.2021.
//

import XCTest
@testable import SixtApp

class SixtServiceTests: XCTestCase {
    
    var apiClient:ApiClient! = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //setup Sixt API client
        apiClient = ApiFactory.service(.sixt)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        //clean the cache
        CacheManager.cars.removeAllObjects()
    }
    
    func testApiClientInstantiated() throws {
        
        XCTAssertNotNil(apiClient, "Sixt API client is not instantiated")
        
        //Is it really Sixt API service?
        if apiClient != nil {
            //arrange
            let baseURL = URL(string: "https://cdn.sixt.io/")
            //act & assert
            XCTAssertTrue(apiClient.baseURL == baseURL, "API is not Sixt's")
        }
    }
    
    func testFetchCars() throws {
        let path = "/codingtask/cars"
        let exp = expectation(description: "API call for cars")
            
         apiClient.fetch(path: path) { result in
            switch result {
            case .failure(let error):

                XCTFail("Error during API call; \(error.localizedDescription))")
                
            case .success(let data):
                let cars = data as! [Car]
                XCTAssertGreaterThan(cars.count, 0, "There is no car returned by API call")
            }
            
            //make sure expectation fullfilled in 3 seconds
            exp.fulfill()
        }
        
        //
        waitForExpectations(timeout: 3.0) { err in
            print(err?.localizedDescription ?? "")
        }
    }
    
    
    
    
    func testParseCarsJson() throws {
        //read text file
        if let path = Bundle(for: type(of: self)).path(forResource: "CarsJson", ofType: "txt"){
            //convert json into data
            if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)){
                
                //parse json data
                let result = apiClient.parseJson(data: data)
                
                switch result {
                case .success(let anyCars):
                    let cars = anyCars as! [Car]
                    //print(cars)
                    XCTAssertGreaterThan(cars.count, 0, "Cars count should be greater than 0")
                    
                case .failure(let apiError):
                    XCTFail("JSON parsing error; \(apiError.localizedDescription)")
                }
                
            }else{
                XCTFail("Data.init failed")
            }
        }else{
            XCTFail("Path not valid")
        }
    }
    
}
