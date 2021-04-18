//
//  loginViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 07/04/21.
//

import UIKit
import Alamofire

struct User:Decodable {
    let refreshToken: String?
    let token: String
    let type: String
}

struct Response:Decodable {
    let status:Bool
    let data:User
}

class loginViewController: UIViewController {

    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var txcontrasena: UITextField!
    @IBOutlet weak var btnIngresar: UIButton!
    
    var user = [User]()
    var response = [Response]()
    var token = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
        let headers:HTTPHeaders = [
            "Accept":"aplication/json"
        ]
        
        if tfCorreo.text! != "" && txcontrasena.text! != "" {
                let parametros = ["email": tfCorreo.text!,"password": txcontrasena.text!]
            AF.request("\(self.defaults.object(forKey: "url") ?? "")login"
, method: .post,parameters: parametros,headers: headers).responseDecodable(of: User.self){ (response) in
                    
                if response.value == nil {
                    self.alertDefault(with: "Error!!", andWith: "La contraseña o el correo es incorrecto")
                    self.btnIngresar.shake()
                    self.tfCorreo.shake()
                    self.txcontrasena.shake()
                }
                guard let user = response.value else { return }
                print(user.token)
                self.defaults.set(user.token, forKey: "token")
                self.defaults.synchronize()
                if let user = self.defaults.string(forKey: "token"){
                        //print(self.defaults.string(forKey: "token"))
                        self.performSegue(withIdentifier: "home", sender: nil)
                    }
                    
            }
        }
            else{
                alertDefault(with: "Error!!", andWith: "Todos los campos deben estar llenos")
                btnIngresar.shake()
                tfCorreo.shake()
                txcontrasena.shake()
        }
    }
}
