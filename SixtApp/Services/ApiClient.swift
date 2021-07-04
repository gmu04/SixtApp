//
//  ApiClient.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation

class ApiClient: NSObject, URLSessionDelegate{
    
    //MARK: - Properties
    private(set) var baseURL: URL!
    
    internal func setBaseURL(_ url:URL){
        self.baseURL = url
    }
    
    func fetch(path:String, completion: @escaping (Result<Any, ApiError>)->Void){
        guard let validURL = URL(string: path, relativeTo: self.baseURL) else {
            completion(.failure(ApiError.cannotInstantiateUrl("\(baseURL.absoluteString) + path: \(path)")))
            return
        }
        //print("\n GET: \(validURL.absoluteString)\n")
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: .main)
        urlSession.dataTask(with: validURL) { (data, response, error) in
            
            //check data & error
            guard let validData = data, error == nil else {
                //print("\n -> ERROR= \(error!.localizedDescription)\n")
                completion(.failure(ApiError.error(error!)))
                return
            }
            
            //Comment for reviewer: if error is nil we do not need check it further when fetching data.
            //  But other situations (ex: CRUD operations) it is mandatory. It is good practice to write following snippet
            
            //check if any http error
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode != 200 {
                //print("API call status: http\(httpURLResponse.statusCode), \"\(httpURLResponse.description)\"")
                completion(.failure(ApiError.httpError(httpURLResponse.statusCode, httpURLResponse.description)))
                return
            }
            
            //return valid json data
            completion(.success(validData))
            
            
        }.resume()
    }
}
