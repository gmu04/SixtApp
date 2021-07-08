//
//  SixtAppUITests.swift
//  SixtAppUITests
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import XCTest

//API might be provided as a library.
//@testable import SixtApp

class SixtAppUITests: XCTestCase {

    //var apiClient:ApiClient! = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    
    func testListingCars() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        let lb = tablesQuery.cells.containing(.staticText, identifier:"M-VO0259").staticTexts["fuelLevel"]
        print(lb.label)
        XCTAssertTrue(lb.label.lowercased().contains(" 70%"), "First element should have 70% fuel.")
        
        
        //XCUIApplication().navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Sixt Cars"].tap()
        //app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Sixt Cars"].tap()
    }
    
}
