//
//  SixtViewController.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import UIKit

class SixtBaseViewController: UIViewController {

    var api:ApiClient!
    var cars:[Car]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// Fetch cars from API Service
    internal func getCars(completion:@escaping ([Car])->Void){
        //TODO: Inject this code
        //let api = ApiFactory.service(.sixt)!
        
        //TODO: dont forget to run it in main queue
        api.fetch(path: "/codingtask/cars", completion: { result in
            
            switch result {
            case .failure(let error):
                //completion(.failure(error))
                let errorMessage: String
                switch error {
                case .cannotInstantiateUrl(let message):
                    errorMessage = message
                    
                case .httpError(let httpCode, let description):
                    errorMessage = "HTTP Error: \(httpCode):\(description)"
                    
                case .serializationError(let e):
                    errorMessage = e.localizedDescription
                    
                case .error(let e):
                    errorMessage = e.localizedDescription
                }
                
                //TODO: If there is error, it should be written to repository such as Crashlytics
                // This is not acceptable in release version
                print(errorMessage)
                
                
            case .success(let data):
                DispatchQueue.main.async {
                    let cars = data as! [Car]
                    
                    //print(self.cars!)
                    completion(cars)
                    
                }
            }
        })
    }
}
