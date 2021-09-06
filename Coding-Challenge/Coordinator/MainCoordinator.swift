import UIKit
import Swinject
class MainCoordinator: Coordinator , MainCoordinatorProctocol {
    let container: Container
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController,container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
  
    func NavigateToTaxiList() {
        let vc = TaxiListViewController.instantiate()
        let viewmodel = container.resolve(BaseViewModel.self ,name:"TaxiViewModel")! as! TaxiViewModel
        vc.coordinator = self
        vc.viewModel = viewmodel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func NavigateToTaxiMap() {
        let vc = TaxiMapViewController.instantiate()
        let viewmodel = container.resolve(BaseViewModel.self,name:"TaxiMapViewModel")! as! TaxiMapViewModel
        vc.coordinator = self
        vc.viewModel = viewmodel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func didFinshed(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
