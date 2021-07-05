//
//  MapViewController.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import UIKit
import MapKit

class MapViewController: SixtBaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var changeMapTypeButton: UIButton!
    @IBOutlet weak var changePitchButton: UIButton!

    
    
    var camera = MKMapCamera()
    var pitch = 0
    var annotations = [CarAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //for rendering custom annotations
        mapView.delegate = self
        
        getCars { cars in
            self.cars = cars
            self.setupLocation()
            self.prepareAnnotations()
        }
    }

    func setupLocation(){
        //setup map based on the first car's locatiom
        if let car = cars.first {
            updateMapCamera(car.coordinate, heading: 0.0, altitute: 8000)
        }
        
    }
    
    private func updateMapCamera(_ coord:CLLocationCoordinate2D, heading:CLLocationDirection, altitute:CLLocationDirection){
        changePitchButton.setTitle("0°", for: .normal)
        changeMapTypeButton.setTitle("Standard view", for: .normal)

        camera.centerCoordinate = coord
        camera.heading = heading
        camera.altitude = altitute
        camera.pitch = 0.0
        mapView.camera = camera
    }
    
    
    @IBAction func changeMapType(_ sender: Any) {
        mapView.mapType.next()
        changeMapTypeButton.setTitle( mapView.mapType == .standard ? "Standard view" : "Satellite view", for: .normal)
        
        //reset pitch
        pitch = 0
        changePitchButton.setTitle("\(pitch)°", for: .normal)
        mapView.camera.pitch = CGFloat(pitch)
    }
    
    
    @IBAction func changePitch(_ sender: UIButton) {
        guard mapView.mapType == .standard else {
            return
        }
        pitch = (pitch + 15) % 90
        sender.setTitle("\(pitch)°", for: .normal)
        mapView.camera.pitch = CGFloat(pitch)
    }
    

    func prepareAnnotations(){
        
        self.annotations = self.cars.map(CarAnnotation.init)
        if self.mapView.annotations.count > 0 {
            self.mapView.removeAnnotations(mapView.annotations)
        }
        self.mapView.addAnnotations(self.annotations)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
