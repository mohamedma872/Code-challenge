//
//  TaxiMapViewModel.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class TaxiMapViewModel : BaseViewModel {
    
    let disposeBag = DisposeBag()
    private let networkInstance: TaxiNetworkProtocal
    init(networkInstance : TaxiNetworkProtocal = TaxiNetworkManager()) {
        self.networkInstance = networkInstance
        markersObservable = markers.asObservable()
    }
    private let loadingBehavior = BehaviorRelay<Bool>(value: false)
    var onShowLoading: Observable<Bool> {
            return loadingBehavior
                .asObservable()
                .distinctUntilChanged()
        }
  
   private let markers = BehaviorRelay<[PoiList]>(value: [])
    var markersObservable: Observable<[PoiList]>

    let onShowError = PublishSubject<String>()
    func getTaxi(northLatitude: Double,
                 eastLongitude: Double,
                 southLatitude: Double,
                 westLongitude: Double) {
        loadingBehavior.accept(true)
        networkInstance
            .getTaxi(northLatitude: northLatitude, eastLongitude: eastLongitude, southLatitude: southLatitude, westLongitude: westLongitude)
            .subscribe(
                onNext: { [weak self] taxiModel in
                    self?.loadingBehavior.accept(false)
                    guard taxiModel?.poiList?.count ?? 0 > 0 else {
                        self?.markers.accept([])
                        return
                    }

                    self?.markers.accept(taxiModel?.poiList ?? [])
                },
                onError: { [weak self] error in
                    self?.loadingBehavior.accept(false)
                    self?.onShowError.onNext(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
     }
   
}
