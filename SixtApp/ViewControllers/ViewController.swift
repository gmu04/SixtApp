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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //deselect row when coming back from detail view
        //  actually in real word user likes to see which cell they tapped... So, making the selecting color might be a better choice. - ask business staff
        guard let selectedIndexPath = tableview.indexPathForSelectedRow else { return }
        tableview.deselectRow(at: selectedIndexPath, animated: animated)
    }
    

}

