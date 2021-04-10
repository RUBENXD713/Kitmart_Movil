//
//  AgregarPendientesViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 09/04/21.
//

import UIKit
import Alamofire

class AgregarPendientesViewController: UIViewController {

    @IBOutlet weak var lblPendientes: UITextField!
    @IBOutlet weak var btnAceptar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func AgregarPendiente(_ sender: UIButton) {
        let headers:HTTPHeaders = [
            "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MDY3ZGJkZTI3NzJkZDM1MzRhYjUyYjMiLCJpYXQiOjE2MTgwMDk1MDJ9.oyXHyJoVFrMNrh6oUDqwJ5_C7UnzowBcfKGTw-35Jw0",
            "Accept":"aplication/json"
        ]
        if lblPendientes.text! != "" {
            let parametros = ["descripcion": lblPendientes.text!]
            AF.request("http://192.168.1.77:3333/api/pendiente", method: .post,parameters: parametros, encoding: URLEncoding.default,headers: headers).responseJSON{
                response in
                let JSON = response.result
                
                print(JSON)}
        }
         else{ alertDefault(with: "Error!!", andWith: "Todos los campos deben estar llenos")
            self.btnAceptar.shake()
            self.lblPendientes.shake()
            
         }
    }

  
}
