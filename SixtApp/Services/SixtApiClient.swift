//
//  SixtApiClient.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation

/// Sixt API client which manages all API calls
///
final class SixtApiClient: ApiClient{
    
    
    //MARK: - Properties
    

    /*  Comment for reviewer:
        I did not prefer to use singleton pattern because I am injecting api client when the app stats, and no need to create it again.
        Besides SixtApi is just used to fetch data - Any threading issues expected for current scenario(s)
     */
    init?(baseUrl:String) {
        //check base url is valid
        guard let url = URL(string: baseUrl) else{
            return nil
        }
        super.init()
        self.setBaseURL(url)
    }


    override func fetch(path: String, completion: @escaping (Result<Any, ApiError>) -> Void) {
        super.fetch(path: path) { result  in //Result<Any, ApiError>
            
            //parse json here
            
            
        }
    }
    
    
    
}
