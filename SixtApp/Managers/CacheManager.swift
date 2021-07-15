//
//  CacheManager.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import Foundation

struct CacheManager{
    
    //cars array after json parsing
    static var cars = NSCache<NSString, AnyObject>()
    
    //car images
    static var carImages = NSCache<NSString, AnyObject>()
    
    
    //Keys
    enum CacheKey:NSString{
        case cars
    }
}

class CarCache:NSObject{
    private(set) var cars:[Car]
    
    init(_ cars:[Car]) {
        self.cars = cars
        super.init()
    }
}
