//
//  CacheManager.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import Foundation

struct CacheManager{
    //caching cars array after json parsing
    static var cars = NSCache<NSString, AnyObject>()
    
    //caching car images
    static var carImages = NSCache<NSString, AnyObject>()
    
    //Keys
    enum CacheKey:NSString{
        case cars, carImages
    }
}

class CarCache:NSObject{
    private(set) var cars:[Car]
    
    init(_ cars:[Car]) {
        self.cars = cars
        super.init()
    }
}
