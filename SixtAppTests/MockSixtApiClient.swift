//
//  MockSixtApiClient.swift
//  SixtAppTests
//
//  Created by Gokhan Mutlu on 6.07.2021.
//

import Foundation
import CoreLocation
@testable import SixtApp

class MockSixtApiClient: ApiClient{
    var baseURL: URL! = URL(string: "https://MOCK.sixt.io/")!
    
    func fetch(path: String, completion: @escaping (Result<Any, ApiError>) -> Void) {
        let cars = getCars()
        completion(Result.success(cars))
    }
    
    func parseJson(data: Data) -> Result<Any, ApiError> {
        let cars = getCars()
        return Result.success(cars)
    }
    
    
    /// Returns mock cars array
    private func getCars() ->[Car]{
        
        let c1 = Car()
        c1.id = "WMWSW31030T222518"
        c1.modelIdentifier = "mini"
        c1.modelName = "MINI"
        c1.name = "Vanessa"
        c1.make = "BMW"
        c1.group = "MINI"
        c1.color = "midnight_black"
        c1.series = "MINI"
        c1.fuelType = "D"
        c1.fuelLevel = 0.7
        c1.transmission = .manuel
        c1.licensePlate = "M-VO0259"
        c1.coordinate = CLLocationCoordinate2D(latitude: 48.134557, longitude: 11.576921)
        c1.innerCleanliness = .regular
        c1.carImageUrl = "https://cdn.sixt.io/codingtask/images/mini.png"
   
        let c2 = Car()
        c2.id = "WMWSU31070T077232"
        c2.modelIdentifier = "mini"
        c2.modelName = "MINI"
        c2.name = "Regine"
        c2.make = "BMW"
        c2.group = "MINI"
        c2.color = "midnight_black"
        c2.series = "MINI"
        c2.fuelType = "P"
        c2.fuelLevel = 0.55
        c2.transmission = .manuel
        c2.licensePlate = "M-I7425"
        c2.coordinate = CLLocationCoordinate2D(latitude: 48.114988, longitude: 11.598359)
        c2.innerCleanliness = .clean
        c2.carImageUrl = "https://cdn.sixt.io/codingtask/images/mini.png"
        
        return [c1, c2]
    }
    
}
