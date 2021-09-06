//
//  TaxiMapViewController.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import UIKit
import RxSwift
import MapKit
class TaxiMapViewController: BaseViewController ,Storyboarded {
    @IBOutlet weak var takiMapView: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    var viewModel : TaxiMapViewModel?
    weak var coordinator: MainCoordinator?
    let locationManager = CLLocationManager()
    var location: CLLocation!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
  
   
    func bindViewModel() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel
            .onShowError
            .subscribe(onNext: { [weak self] in
                self?.alert(title: "error", message: $0)
            }).disposed(by: disposeBag)
        
        viewmodel
            .onShowLoading
            .map { [weak self] in
                if $0 {
                self?.showIndicator()
            } else {
                self?.hideIndicator()
            } }
            .subscribe()
            .disposed(by: disposeBag)
        subscribeToResponse()
        getTaxiList()
       
    }
    func subscribeToResponse() {
        guard  let viewmodel = viewModel else {
            return
        }
       
        viewmodel.markersObservable.subscribe(onNext: { [weak self] vehicles in
            guard let self = self else {return}
            for item in vehicles {
                let coordinate = CLLocationCoordinate2D(latitude: item.coordinate?.latitude ?? 0.0, longitude: item.coordinate?.longitude ?? 0.0)
                self.addAnnotation(coordinate)
            }
           
        }) .disposed(by: disposeBag)
    }
    func getTaxiList() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel.getTaxi(northLatitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lat1, eastLongitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lon1, southLatitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lat2, westLongitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lon2)
    }
    
    

}
