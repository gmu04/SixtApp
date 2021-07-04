//
//  InnerCleanliness.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation

enum InnerCleanliness:String, Decodable{
    case unknown    = "not specified"
    case veryClean  = "VERY_CLEAN"
    case clean      = "CLEAN"
    case regular    = "REGULAR"
}
