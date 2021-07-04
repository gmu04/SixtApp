//
//  Auto.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation

/*  Comment for reviewer:
    
    Using struct which has all parameters seems to be more convenient and a bit faster to decode json and show the results on screen.
    Besides usings protocols with sturcs for future needs might be advantages too.
    
    Nevertheless I prefer to use classes because it seems to give more freedom to mimic full domain.
    For example inheritance hierachy migh be like; Auto ⇠ Car ⇠ Bwm, or Auto ⇠ Truck ⇠ Volvo, etc.
    
    Possible business rules:
        (-) check id - it should be unique in given set of cars
        (-) check if tranmission is other than A or M
        (-) some of the fields should be nil. Ask domain expert. Examine API schema.
*/

internal class Auto: Decodable{
    var id = "",
        modelIdentifier = "",
        modelName = "",
        name = "",
        make = "",
        group = "",
        color = "",
        series = "",
        fuelType = "",
        transmission = Transmission.manuel
}
