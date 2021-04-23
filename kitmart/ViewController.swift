//
//  ViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 22/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagen.bounce()
        defaults.setValue("http://192.168.1.86:3333/api/", forKey: "url")
        defaults.setValue("ws://192.168.1.86:3333/adonis-ws", forKey: "WS")
        self.defaults.synchronize()
        let va = "\(self.defaults.object(forKey: "url") ?? "")login"
        print(va)
        print(self.defaults.object(forKey: "WS") ?? "")
        
        
        
        if let value = self.defaults.string(forKey: "token"){
            print(defaults.string(forKey: "token") ?? "")
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
