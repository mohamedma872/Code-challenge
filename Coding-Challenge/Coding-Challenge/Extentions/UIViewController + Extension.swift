import Foundation
import UIKit
import MBProgressHUD
import RxSwift
import RxCocoa
import RxSwiftExt
extension UIViewController {
    
    func showIndicator() {
        DispatchQueue.main.async {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = ""
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = ""
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
        }
    }
    func hideIndicator() {
        DispatchQueue.main.async {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
        }
    }
    func bind(textField: UITextField, to behaviorRelay: BehaviorRelay<String>, disposeBag: DisposeBag) {
            behaviorRelay.asObservable()
                .bind(to: textField.rx.text)
                .disposed(by: disposeBag)
            textField.rx.text.unwrap()
                .bind(to: behaviorRelay)
                .disposed(by: disposeBag)
        }
        
        func bind(button: UIButton, to behaviorRelay: BehaviorRelay<String>, disposeBag: DisposeBag) {
            behaviorRelay.asObservable()
                .bind(to: button.rx.title())
                .disposed(by: disposeBag)
        }
        
        func bind(label: UILabel, to behaviorRelay: BehaviorRelay<String>, disposeBag: DisposeBag) {
            behaviorRelay.asObservable()
                .bind(to: label.rx.text)
                .disposed(by: disposeBag)
        }
        
        func bind(textView: UITextView, to behaviorRelay: BehaviorRelay<String>, disposeBag: DisposeBag) {
            behaviorRelay.asObservable()
                .bind(to: textView.rx.text)
                .disposed(by: disposeBag)
            textView.rx.text.unwrap()
                .bind(to: behaviorRelay)
                .disposed(by: disposeBag)
        }
        func alert(title : String, message : String) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        func alert(title : String, message : String , complete :@escaping () -> Void) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                complete()
            }))
            self.present(alert, animated: true, completion: nil)
        }
}
