//
//  CarAnnotation.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import UIKit
import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let identifier = "Pin"
    
    var carPhoto:UIImage! = nil
    
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    convenience init(car:Car){
        self.init(coordinate:car.coordinate,
                  title: "\(car.make), \(car.modelName)",
                  subtitle: "transmission: \(car.transmission), fuel level:\(String(format: "%0.0f", car.fuelLevel*100))")
        
        if let img = CacheManager.carImages.object(forKey: car.id as NSString) as? UIImage {
            self.carPhoto = img
        }
        else{
            
            
            #warning("I think cache is not sufficient. Check instruments &| find a better solution.")
            //TODO: Due to time constraint of the project, I will be downloading some of the images synchronously.
            if let url = URL(string: car.carImageUrl ?? ""),
               let validData = try? Data(contentsOf: url){
                
                /*#if DEBUG
                 print("-->\(car.id) \(url) --- ")
                 #endif*/
                
                self.carPhoto = UIImage(data: validData)
            }else{
                
                /*#if DEBUG
                print("--- \(car.id) --- ")
                #endif*/
                
                self.carPhoto = UIImage(named: "defaultCar")
            }
        }
        
        
    }
    
    
}
