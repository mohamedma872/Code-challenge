import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set (borderWidth) {
            self.layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable
    public var borderColor:UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set (color) {
            self.layer.borderColor = color?.cgColor
        }
        
    }
    func circle() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
