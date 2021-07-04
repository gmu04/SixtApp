//
//  ViewController.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import UIKit

class ViewController: UIViewController {

    private(set) var api:ApiClient!
    
   
    convenience init?(coder: NSCoder, api:ApiClient) {
        self.init(coder:coder)
        self.api = api
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
                print(errorMessage)
                
            case .success(let data):
                //print("\(jsonData)")
                
                //parse json here
                let cars = data as! [Car]
                print(cars)

            }
        })
        
        
        
        
    }


}

