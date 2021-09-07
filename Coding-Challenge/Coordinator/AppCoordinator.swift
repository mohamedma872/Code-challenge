import UIKit
import Swinject
class AppCoordinator : Coordinator {
    // Dependency Injection Container is an object that knows how to
    // instantiate and configure objects. DI Container is a design pattern to
    // implement Dependency injection. One benefit of using it to resolve Complex dependency
    let container: Container
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let window : UIWindow?
    
    init(window: UIWindow? , navigationController: UINavigationController, container: Container) {
        self.window = window
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let myCoordinator = MainCoordinator(navigationController: navigationController,container: container)
        addCoordinator(coordinator: myCoordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        myCoordinator.start()
    }
}
