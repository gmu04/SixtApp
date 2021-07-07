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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValues(car:Car){
        
        //get car image from cache
        if let img = CacheManager.carImages.object(forKey: car.id as NSString) as? UIImage {
            carImage.image = img
            statusIndicator.stopAnimating()
        }else{
            
            //or, download it
            downloadImage(car) { img in

                self.statusIndicator.stopAnimating()
                
                guard img != nil else {
                    self.carImage.image = UIImage(named: "defaultCar")
                    return
                }

                self.carImage.image = img
            }
        }
        
        makeLabel.text = "\(car.make), \(car.modelName)"
        licensePlateLabel.text = car.licensePlate
        
        let fuelLevel = String.init(format: "%.0f", car.fuelLevel*100)
        fuelLevelLabel.text = "Fuel level: \(fuelLevel)%"
    }
    
    private func downloadImage(_ car:Car, completion: @escaping (UIImage?)->Void){
        if let url = URL(string: car.carImageUrl!){
            //It is synch -> forget it
            //let data = try Data(contentsOf: url)
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let validatedData = data, error == nil else{
                    DispatchQueue.main.async { completion(nil) }
                    return
                }
                if let img = UIImage(data: validatedData){
                    //cache image
                    CacheManager.carImages.setObject(img as AnyObject, forKey: car.id as NSString)
                    
                    DispatchQueue.main.async {
                        completion(img)
                    }
                }else{
                    DispatchQueue.main.async { completion(nil) }
                }
            }.resume()
            
        }
    }
 
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.carImage.image = nil
    }
}
