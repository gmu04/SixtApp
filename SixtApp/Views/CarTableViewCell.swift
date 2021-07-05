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
    
    //For production fuelLevel should be dynamicly rendered image
    @IBOutlet weak var fuelLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(car:Car){

        carImage.image = getImage(car)
        makeLabel.text = "\(car.make), \(car.modelName)"
        licensePlateLabel.text = car.licensePlate
        
        let fuelLevel = String.init(format: "%.0f", car.fuelLevel*100)
        fuelLevelLabel.text = "Fuel level: \(fuelLevel)%"
    }
    
    private func getImage(_ car:Car) -> UIImage{
        var carImage = UIImage(named: "defaultCar")!
        
        //get car image from cache
        if let img = CacheManager.carImages.object(forKey: car.id as NSString) as? UIImage {
            carImage = img
        }else{
            //download image
            do {
                if let url = URL(string: car.carImageUrl!){
                    let data = try Data(contentsOf: url)
                    if let img = UIImage(data: data){
                        carImage = img
                        
                        //cache image
                        CacheManager.carImages.setObject(carImage as AnyObject, forKey: car.id as NSString)
                    }
                }
            } catch {
                print(error.localizedDescription, error)
                
            }
        }
        return carImage
    }
}
