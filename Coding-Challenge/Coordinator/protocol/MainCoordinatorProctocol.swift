import Foundation
protocol MainCoordinatorProctocol : AnyObject {
    /**
     Invoked when the Main flow is no longer needed
     */
     func didFinshed(_ child : Coordinator)
}
