import UIKit
import Swinject
protocol Coordinator : AnyObject {
    /**
     DI container
     */
    var container: Container { get }
    /**
     Navigation controller
     */
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get set }
    
    /**
     Entry point starting the coordinator
     */
    func start()
    
}

extension Coordinator {
    
    func addCoordinator(coordinator : Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeCoordinator(coordinator : Coordinator) {
        childCoordinators =  childCoordinators.filter({$0 !== coordinator})
    }
}
