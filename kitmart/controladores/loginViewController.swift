//
//  loginViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 07/04/21.
//

import UIKit
import Alamofire

struct User:Decodable {
    let refreshToken: String
    let token: String
    let type: String
}

class loginViewController: UIViewController {

    @IBOutlet weak var tfCorreo: UITextField!
    @IBOutlet weak var txcontrasena: UITextField!
    @IBOutlet weak var btnIngresar: UIButton!
    
    var user = [User]()
    var token = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.performSegue(withIdentifier: "home", sender: nil)
        
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
        let headers:HTTPHeaders = [
            "Accept":"aplication/json"
        ]
        
        if tfCorreo.text! != "" && txcontrasena.text! != "" {
                let parametros = ["email": tfCorreo.text!,"password": txcontrasena.text!]
            AF.request("http://192.168.1.77:3333/api/login", method: .post,parameters: parametros, encoding: URLEncoding.default,headers: headers).responseData{ [self]
                    (response) in
                    
                    let JSON = response.result
                    let jsonw = response.data
                    print(JSON)
                    print(jsonw)
                
                    do{
                        //let datos = ["token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MDZiYTg2Njk5MTA5MDJlNTAwZjUwZTMiLCJpYXQiOjE2MTc5OTkwODN9.4jj_LVmm9EcsIhMdv916wi5Y11xUWmsDmfxtipi8uuE","_id": "1"]
                        //self.defaults.set(datos, forKey: "session")
                        self.user = try JSONDecoder().decode([User].self, from: jsonw!)
                        print()
                    }catch{
                        print("error")
                        //return
                    }
                    
                self.token = ""//self.user.token
                    if self.token == ""{
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
