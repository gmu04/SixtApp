//
//  ApiClient.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import UIKit


/*  Comment for reviewer:
    Factory design pattern to sperate concerns.
        (It becomes more imporant when initialization requires more than a few parameters.)
 */
final class ApiFactory{
    static func service(_ service:ApiService) -> ApiClient?{
        var apiClient:ApiClient!
        
        switch service {
        case .sixt:
            //TODO:get it from plist
            let baseUrl = "https://cdn.sixt.io/codingtask"   // /cars"
            apiClient = SixtApiClient(baseUrl: baseUrl)
        default:
            apiClient = nil
        }
        
        return apiClient
    }
}


/*  Comment for reviewer:
    App might use differnt API services such as weather, financial services, traffic data, etc. in addition to handling its primary assets.
 */
enum ApiService{
    case sixt
    case xxxBank        //
    case weatherCom     //such as https://weather.com/
    case yyyPayment
    case zzzService
}
