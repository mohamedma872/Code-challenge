import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

// default Implementation for protocol Storyboarded
// Extend protocol Storyboarded, where `Self` is of type `UIViewController`
// func instantiate() will only exist for classes that inherit `UIViewController`.
// In fact, this entire extension only exists for `UIViewController` subclasses.

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
}
