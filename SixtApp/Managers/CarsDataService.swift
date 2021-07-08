//
//  CarsDataService.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 8.07.2021.
//

import UIKit

class CarsDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private(set) var cars:[Car]! = nil
    init(cars:[Car]) {
        self.cars = cars
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CarTableViewCell
        
        let car = self.cars[indexPath.row]
        cell.setValues(car: car)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
