//
//  ViewController + ext + tableview.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import UIKit
import SwiftUI

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CarTableViewCell
        
        cell.statusIndicator.startAnimating()
        
        let car = self.cars[indexPath.row]
        cell.setValues(car: car)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBSegueAction func carDetailViewSegue(_ coder: NSCoder) -> UIViewController? {
        guard let indexPath = self.tableview.indexPathForSelectedRow else { fatalError("OPPS! You are trying to view a car's info without selecting it first") }
        let selectedCar = cars[indexPath.row]
        return UIHostingController(coder: coder, rootView: CarDetailView(car: selectedCar))
    }
}

