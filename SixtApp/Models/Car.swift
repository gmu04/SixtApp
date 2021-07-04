//
//  Car.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation
import CoreLocation


//TODO: Possible business rules:
/*
 (-) check fuel level, negative or more then 1 is not acceptable
 (-) fuel level is below xyz then create a warning message
 (-) check latitude, longitude - Sixt has no car in North Pole, on the middle of tiny Passific island
 (-) check if image exists, otherwise set it as the default image name
 (-) if innerCleanliness is null, do we consider the car clean (min. level to show off) or .unknown state
 (-) offer team not send "https://cdn.sixt.io/codingtask/images/" part of image. (May be company rents other companies cars'...)
*/


/*  Comment for reviewer:

*/


class Car:Auto{
    var licensePlate:String
    var fuelLevel:Double
    var coordinate:CLLocationCoordinate2D   //check latitude, longitude - no car in japan
    var innerCleanliness:InnerCleanliness?
    var carImageUrl:String?                 //check image exist, otherwise set default, check URL
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CarCodingKey.self)
        
        licensePlate = try container.decode(String.self, forKey: .licensePlate)
        fuelLevel = try container.decode(Double.self, forKey: .fuelLevel)
        
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        innerCleanliness = try container.decodeIfPresent(InnerCleanliness.self, forKey: .innerCleanliness) ?? .clean // ask it
        carImageUrl = try container.decodeIfPresent(String.self, forKey: .carImageUrl)
        
        
        try super.init(from: decoder)
    }
    
    private enum CarCodingKey:String, CodingKey{
        case licensePlate, fuelLevel, latitude, longitude, innerCleanliness, carImageUrl
    }
}
