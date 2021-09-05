//
//  TaxiViewModel.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import Foundation
import RxSwift
import RxCocoa
enum TaxiTableViewCellType {
    case normal(cellViewModel: TaxiCellViewModel)
    case error(message: String)
    case empty
}
class TaxiViewModel : BaseViewModel {
    
    let disposeBag = DisposeBag()
    private let networkInstance: TaxiNetworkProtocal
    init(networkInstance : TaxiNetworkProtocal = TaxiNetworkManager()) {
        self.networkInstance = networkInstance
        CellsObservable = cells.asObservable()
    }
    private let loadingBehavior = BehaviorRelay<Bool>(value: false)
    var onShowLoading: Observable<Bool> {
            return loadingBehavior
                .asObservable()
                .distinctUntilChanged()
        }
  
   private let cells = BehaviorRelay<[TaxiTableViewCellType]>(value: [])
    var CellsObservable: Observable<[TaxiTableViewCellType]>

    let onShowError = PublishSubject<String>()
    func getTaxi(northLatitude: Double,eastLongitude
                    : Double,southLatitude: Double,westLongitude: Double) {
        loadingBehavior.accept(true)
        networkInstance
            .getTaxi(northLatitude: northLatitude, eastLongitude: eastLongitude, southLatitude: southLatitude, westLongitude: westLongitude)
            .subscribe(
                onNext: { [weak self] taxiModel in
                    self?.loadingBehavior.accept(false)
                    guard taxiModel?.poiList?.count ?? 0 > 0 else {
                        self?.cells.accept([.empty])
                        return
                    }

                    self?.cells.accept((taxiModel?.poiList?.compactMap { .normal(cellViewModel: TaxiCellViewModel(model: $0 )) })!)
                },
                onError: { [weak self] error in
                    self?.loadingBehavior.accept(false)
                    self?.onShowError.onNext(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
     }
   
}
