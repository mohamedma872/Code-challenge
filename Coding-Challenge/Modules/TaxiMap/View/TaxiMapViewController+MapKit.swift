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

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}
class CustomAnnotationView : MKPinAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let ccustomView = Bundle.main.loadNibNamed("CustomAnntionView", owner: self, options: nil)?.first as! UIView
        let selectedLabel:UILabel = ccustomView.viewWithTag(101) as! UILabel
        selectedLabel.text = annotation?.title ?? "place"
        selectedLabel.textAlignment = .natural
        selectedLabel.backgroundColor = Asset.whiteThree.color

        selectedLabel.layer.masksToBounds = true
        selectedLabel.textColor = Asset.darkGreyBlue.color
        //selectedLabel.font = FontStyle.sfProTextBold12.FontFormat().withSize(10)
        ccustomView.frame = CGRect(x: 30, y: 0, width: 155, height: 35)
        self.addSubview(ccustomView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TaxiMapViewController: MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedAlways  {
            // do stuff
            setupMapView()
        }
        if status == .authorizedWhenInUse  {
            
            // do stuff
            setupMapView()
        }
        if status == .denied {
            self.alertWithCancle(title: L10n.validation, message: L10n.gpsValidation) { [weak self] in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    self?.coordinator?.start()
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: {  [weak self] value in
                        guard value else {
                            self?.coordinator?.start()
                            return
                        }
                        self?.setupLocation()
                    })
                }

            } cancel: { [weak self] in
                self?.coordinator?.start()
            }
        }
    }
    func setupLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
                setupMapView()
            @unknown default:
                self.locationManager.startUpdatingLocation()
                setupMapView()
            }
        } else {
            print("Location services are not enabled")
        }
        
    }
    @IBAction func currentPositionClicked(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        if let coordinate = location?.coordinate
        {
            let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: center, span: span)
            takiMapView.setRegion(region, animated: true)
        }
        
    }
    func setupMapView() {
        locationManager.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else {return}
            self.takiMapView.delegate = self
            self.takiMapView.showsUserLocation = true
            //                guard let location = self.locationManager.location?.coordinate else { return }
            
            // for test
            let location = CLLocationCoordinate2D(latitude: 25.3511109, longitude: 55.4072837)
            
        
            
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: center, span: span)
            self.takiMapView.setRegion(region, animated: true)// Change `2.0` to the desired number of
            self.viewModel?.getTaxi(northLatitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lat1, eastLongitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lon1, southLatitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lat2, westLongitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lon2)
        }
       
    }
    func addAnnotation(_ coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async { [weak self ] in
            guard let self = self else {return}
            let annotation = CustomPointAnnotation()
            annotation.coordinate = coordinate
            annotation.imageName = Asset.takiMarker.name
            self.takiMapView.addAnnotation(annotation)
        }
        
    }
    // show current location and update location on map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentlocation = locations.last else { return}
        location  = currentlocation
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: "test")
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: "test")
            anView?.canShowCallout = true
        } else {
            anView?.annotation = annotation
        }
        let size = CGSize(width: 80, height: 80)
        guard annotation.coordinate.latitude != locationManager.location?.coordinate.latitude ?? 0.0 else {
            anView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "test")
            anView?.image = UIImage(named: Asset.takiMarker.name)
            anView?.sizeThatFits(size)
            return anView
        }
       
        
        anView?.sizeThatFits(size)
        return anView
    }
}
