//
//  CarTableViewCell.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var statusIndicator: UIActivityIndicatorView!
    
    //For production fuelLevel should be dynamicly rendered image
    @IBOutlet weak var fuelLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    
    func setValues(car:Car){
        makeLabel.text = "\(car.make), \(car.modelName)"
        licensePlateLabel.text = car.licensePlate
        
        let fuelLevel = String.init(format: "%.0f", car.fuelLevel*100)
        fuelLevelLabel.text = "Fuel level: \(fuelLevel)%"
        
        
        //get car image from cache
        if let carImageName = car.carImageName,
           let img = CacheManager.carImages.object(forKey: carImageName as NSString) as? UIImage {
            carImage.image = img
            statusIndicator.stopAnimating()
        } else{

            carImage.image = nil

            //or, download it
            downloadImage(car) { img in

                DispatchQueue.main.async {
                    self.carImage.image =  img == nil ? UIImage(named: "defaultCar") : img
                    self.statusIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func downloadImage(_ car:Car, completion: @escaping (UIImage?)->Void){
        if let carImageUrl = car.carImageUrl, let url = URL(string: carImageUrl){
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let validatedData = data, error == nil else{
                    completion(nil)
                    return
                }
                if let img = UIImage(data: validatedData){
                    //cache image
                    CacheManager.carImages.setObject(img as AnyObject, forKey: car.carImageName! as NSString)
                    completion(img)
                }else{
                    completion(nil)
                }
            }.resume()
            
        }
    }
 
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.carImage.image = nil
    }
}
