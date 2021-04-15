//
//  ViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 22/03/21.
//

import UIKit

class ViewController: UIViewController {

    /*let defaults = UserDefaults.standard
    var token = ""
    var session:NSObject = [""] as NSObject*/
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let va = "\(self.defaults.object(forKey: "url") ?? "")login"
        print(va)
        self.defaults.synchronize()
        
        
        if let value = self.defaults.string(forKey: "token"){
            print(defaults.string(forKey: "token"))
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                self.performSegue(withIdentifier: "Splash->Home", sender: nil)
                
            }
            
        }else {
            //print(defaults.string(forKey: "token"))
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                self.performSegue(withIdentifier: "Login", sender: nil)
                }
            //}
        // Do any additional setup after loading the view.
    }


}

}
