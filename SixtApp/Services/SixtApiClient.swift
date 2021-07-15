//
//  SixtApiClient.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import UIKit

/// Sixt API client which manages all API calls
///
final class SixtApiClient: NSObject, ApiClient{
    
    
    //MARK: - Properties
    private(set) var baseURL: URL!
    
    //serial queue - run async
    lazy private var urlSession =
        URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: nil, delegateQueue: .main)


    //MARK: - Initializers
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

    
    //MARK: - Methods
    
    
    func fetch(path:String, completion: @escaping (Result<Any, ApiError>)->Void){
        
        //get cars from cache
        if let carCache = CacheManager.cars.object(forKey: CacheManager.CacheKey.cars.rawValue) as? CarCache {
            completion(.success(carCache.cars))
            return
        }
        
        //check url
        guard let validURL = URL(string: path, relativeTo: self.baseURL) else {
            completion(.failure(ApiError.cannotInstantiateUrl("\(baseURL.absoluteString) + path: \(path)")))
            return
        }
        
        
        urlSession.dataTask(with: validURL) { (data, response, error) in
            
            //check data & error
            guard let validData = data, error == nil else {
                //print("\n -> ERROR= \(error!.localizedDescription)\n")
                DispatchQueue.main.async { completion(.failure(ApiError.error(error!))) }
                return
            }
            guard response != nil,
                  let mime = response?.mimeType,
                  mime == "application/json" else {
                print("Wrong MIME type!")
                DispatchQueue.main.async { completion(.failure(ApiError.jsonDataExpected))
                }
                return
            }
            
            //check if any http error
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode != 200 {
                //print("API call status: http\(httpURLResponse.statusCode), \"\(httpURLResponse.description)\"")
                DispatchQueue.main.async { completion(.failure(ApiError.httpError(httpURLResponse.statusCode, httpURLResponse.description))) }
                return
            }
            
            
            //parse json here (sperate json parsing for unit tests)
            let result = self.parseJson(data: validData)
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            
            case .success(let carsAny):
                //Put cars into cache (- I will also need the same data in MapView)
                let cars = carsAny as! [Car]
                let carCache = CarCache(cars)
                CacheManager.cars.setObject(carCache, forKey: CacheManager.CacheKey.cars.rawValue)
                
                DispatchQueue.main.async {
                    completion(.success(cars))
                }
            }
            
            
        }.resume()
    }
    
    /**
        Parses given data
        - Parameter data: json data in UTF8 to be parsed
        - Returns: Result enum retuns either [Car], or ApiError
     */
    func parseJson(data:Data) -> Result<Any, ApiError>{
        do {
            let cars = try JSONDecoder().decode([Car].self, from: data)
            //print(cars)
            return .success(cars)
        } catch {
            //print(error.localizedDescription, error)
            return .failure(.serializationError(error))
        }
    }
}
