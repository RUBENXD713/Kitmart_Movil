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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //session = defaults.object(forKey: "session") as! NSObject
        
        
        /*if token != ""{
            print(self.token)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                self.performSegue(withIdentifier: "Splash->Home", sender: nil)
                
            }
            
        }else {
            print(self.token)*/
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    self.performSegue(withIdentifier: "Login", sender: nil)
                }
            //}
        // Do any additional setup after loading the view.
    }


}

