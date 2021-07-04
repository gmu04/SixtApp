//
//  SixtApiClient.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation

/// Sixt API client which manages all API calls
///
final class SixtApiClient: NSObject, ApiClient, URLSessionDelegate{
    
    
    //MARK: - Properties
    private(set) var baseURL: URL!

    
    
    /*  Comment for reviewer:
        I did not prefer to use singleton pattern because I am injecting api client when the app starts, and wont be necessary to create it later.
        Besides SixtApi is just used to fetch data - Any threading issues expected for current scenario(s)
     */
    init?(baseUrl:String) {
        //check base url is valid
        guard let url = URL(string: baseUrl) else{
            return nil
        }
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
            

            
            //parse json here
            do {
                let cars = try JSONDecoder().decode([Car].self, from: validData)
                //print(cars)
                completion(.success(cars))
            } catch {
                print(error.localizedDescription, error)
                completion(.failure(.serializationError(error)))
            }
            
            
        }.resume()
    }

}
