//
//  Extenciones.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 07/04/21.
//

import UIKit

extension UIView {
    func round() {
        self.layer.cornerRadius = self.bounds.height / 2
    }
    func circular() {
        self.layer.cornerRadius = self.bounds.height / 5
    }
    func roundSuave() {
        self.layer.cornerRadius = self.bounds.height / 50
    }
    
    func shake(){
            self.transform = CGAffineTransform(translationX: 25, y: 0)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
    }
    
    func pulse() {
        UIView.animate(withDuration: 0.5) {
            self.transform=CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (c) in
            UIView.animate(withDuration: 1){
                self.transform = .identity
            } completion: { (c) in
                self.pulse()
            }
        }
    }
    
    func bounce(){
        UIView.animate(withDuration:0.2){
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (com) in
            if com {
                UIView.animate(withDuration: 0.2){
                    self.transform = .identity
                }
            }
        }
    }
    
}
extension UIViewController {
    func alertDefault(with title:String, andWith description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey!", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
}
