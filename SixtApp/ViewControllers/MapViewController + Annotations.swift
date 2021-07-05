//
//  MapViewController + Annotations.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import UIKit
import MapKit

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CarAnnotation else{ return nil }

        let annotationView =
            mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier)
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        
        //show annotation info
        annotationView.canShowCallout = true
        
        //show image (instead of pin)
        annotationView.image = UIImage(named: "defaultCarPin")
        
        let paragraph = UILabel()
        paragraph.numberOfLines = 1//0
        paragraph.adjustsFontSizeToFitWidth = true
        paragraph.font = UIFont.preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.subtitle
        annotationView.leftCalloutAccessoryView = UIImageView(image: annotationView.image)
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoLight)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = AnnotationDetailViewController(nibName: "AnnotationDetailViewController", bundle: Bundle.main)
        if let annotation = view.annotation as? CarAnnotation{
            vc.annotation = annotation
            present(vc, animated: true)
        }
    }
    
    
}
