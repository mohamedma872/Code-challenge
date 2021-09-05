//
//  TaxiListViewController.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
class TaxiListViewController: UIViewController {
    @IBOutlet weak var TaxiTableView: UITableView!
   // weak var coordinator: MainCoordinator?
    let taxiTableViewCell = "TaxiTableViewCell"
    var viewModel : TaxiViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    func setupTableView() {
        TaxiTableView.register(UINib(nibName: taxiTableViewCell, bundle: nil), forCellReuseIdentifier: taxiTableViewCell)
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
        viewmodel.CellsObservable.bind(to: self.TaxiTableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .normal(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaxiTableViewCell", for: indexPath) as? TaxiTableViewCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel
                return cell
                
            case .error(let message):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = message
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "noDataAvailable"
                return cell
            }
        }.disposed(by: disposeBag)
       
    }
    func getTaxiList() {
        guard  let viewmodel = viewModel else {
            return
        }
        viewmodel.getTaxi(northLatitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lat1, eastLongitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lon1, southLatitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lat2, westLongitude: DEFAULT_HAMBURG_LOCATION_LIMITS.lon2)
    }
    
    

}
