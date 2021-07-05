//
//  MapType.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import MapKit

extension MKMapType{
    mutating func next(){
        switch self {
        case .standard:
            self = .satellite
        case .satellite:
            self = .standard
            //No need to support for the demo
//        case .hybrid:
//        case .satelliteFlyover:
//        case .hybridFlyover:
        
        default:
            fatalError()
        }
    }
}
