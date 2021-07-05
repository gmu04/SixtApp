//
//  ViewController.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import UIKit


class ViewController: SixtBaseViewController {

    @IBOutlet weak var tableview: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TESTING
        //CacheManager.carImages.removeAllObjects()
        
        
        //Fetching data takes a while when "Very bad network condition" level of "Network Link Conditioner",
        //so, I try to get data when the controller is instantiated in SceneDelegate, instead of calling it in viewDidLoad
        /*getCars { cars in
            self.cars = cars
            self.tableview.reloadData()
        }*/
    }
    
    
    

}

