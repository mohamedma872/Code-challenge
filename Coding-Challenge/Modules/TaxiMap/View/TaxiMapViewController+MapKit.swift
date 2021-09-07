//
//  TaxiMapViewController+MapKit.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import Foundation
import UIKit
import MapKit
import RxSwift


extension TaxiMapViewController: MKMapViewDelegate, UIGestureRecognizerDelegate {
   
   
    func setupMapView() {
        locationManager.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else {return}
            self.takiMapView.delegate = self
            self.takiMapView.showsUserLocation = true
            let center = CLLocationCoordinate2D(latitude: DEFAULT_HAMBURG_LOCATIONS.LATITUDE, longitude: DEFAULT_HAMBURG_LOCATIONS.LONGITUDE)
            let span = MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
            let region = MKCoordinateRegion(center: center, span: span)
            self.takiMapView.setRegion(region, animated: true)
           
        }
       
    }
    func addAnnotation(_ coordinate: CLLocationCoordinate2D,tittle: String,heading: String) {
        DispatchQueue.main.async { [weak self ] in
            guard let self = self else {return}
            let annotation = CustomPointAnnotation()
            annotation.coordinate = coordinate
            annotation.imageName = Asset.takiMarker.name
            annotation.title = tittle
            annotation.heading = heading
            self.takiMapView.addAnnotation(annotation)
        }
        
    }
     func removeAnnotationsOnMap() {
        DispatchQueue.main.async {
            for annotation in self.takiMapView.annotations {
            if !(annotation is MKUserLocation) {
                self.takiMapView.removeAnnotation(annotation)
            }
        }
        }
     }
    // show current location and update location on map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentlocation = locations.last else { return}
        location  = currentlocation
        
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("\(#function)")
        self.viewModel?.getTaxi(northLatitude: mapView.northWestCoordinate.latitude, eastLongitude: mapView.southEastCoordinate.longitude, southLatitude: mapView.southEastCoordinate.latitude, westLongitude: mapView.northWestCoordinate.longitude)
       
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier) as? CustomAnnotationView else { return nil }
        let annotation = annotation as! CustomPointAnnotation
        let image = Asset.takiMarker.image
        let rotation = CGFloat(Double(annotation.heading)!/180 * Double.pi)
        annotationView.image = image.rotate(radians: rotation)
        annotationView.canShowCallout = true
        annotationView.frame.size.height = 30
        annotationView.frame.size.width = 30
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        annotationView.annotation = annotation
        return annotationView
        
    }
    
   
}
extension MKMapView {
    var northWestCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.minY).coordinate
    }
    
    var northEastCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.minY).coordinate
    }
    
    var southEastCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.maxX, y: visibleMapRect.maxY).coordinate
    }
    
    var southWestCoordinate: CLLocationCoordinate2D {
        return MKMapPoint(x: visibleMapRect.minX, y: visibleMapRect.maxY).coordinate
    }
}

