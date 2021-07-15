//
//  CarDetailView.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import SwiftUI

struct CarDetailView: View {
    var car:Car
    private let color_ = Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
    
    
    var body: some View {
        VStack{
            //            Text(car.id)
            //            Text(car.modelIdentifier)
            //            Text(car.group)
            HStack(spacing:20) {
                Text(car.make)
                Text(car.modelName)
            }
            .foregroundColor(.blue)
            .font(.largeTitle)
            .padding(5)
            
            GeometryReader { geo in
                Image(uiImage: getImage())
                    .resizable()
                    .frame(width: geo.size.width - 40)//padding = 40
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color_, lineWidth: 1))
                    .shadow(radius: 5)
                    .padding()
            }
            
            Form{
                Section (header:
                            Text("Car Info")
                                .foregroundColor(color_)){
                    HStack(){
                        Text("Color:")
                        Spacer()
                        Text(car.color)
                            .foregroundColor(color_)
                    }
                    HStack{
                        Text("Series:")
                        Spacer()
                        Text(car.series)
                            .foregroundColor(color_)
                    }
                    
                    
                    HStack{
                        Text("Transmission:")
                        Spacer()
                        Text(car.transmission.rawValue)
                            .foregroundColor(color_)
                    }
                    
                    HStack{
                        Text("License Plate:")
                        Spacer()
                        Text(car.licensePlate)
                            .foregroundColor(color_)
                    }
                    
                    HStack{
                        Text("Coordinates:")
                        Spacer()
                        HStack {
                            Text("\(car.coordinate.latitude)")
                            Text(",")
                            Text("\(car.coordinate.longitude)")
                        }
                        .foregroundColor(color_)
                    }
                    HStack{
                        Text("Fuel Type & Level:")
                        Spacer()
                        HStack {
                            Text("\(car.fuelType)")
                            Text(",")
                            Text("\(String(format: "%0.0f", car.fuelLevel*100)) %")
                        }
                        .foregroundColor(color_)
                    }
                    HStack(){
                        Text("Inner Cleanliness:")
                        Spacer()
                        Text(car.innerCleanliness!.rawValue)
                            .foregroundColor(color_)
                    }
                }
            }
            
            Spacer()
            
        }
    }
    
    
    private func getImage() -> UIImage{
        let image:UIImage
        if let img = CacheManager.carImages.object(forKey: self.car.carImageName! as NSString) as? UIImage {
            image = img
        }else{
            image = UIImage(named: "defaultCar")!
        }
        return image
    }
}

struct CarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailView(car: Car.sampleCar)
    }
}
