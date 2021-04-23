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
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func AgregarPendiente(_ sender: UIButton) {
        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
        if lblPendientes.text! != "" {
            let parametros = ["descripcion": lblPendientes.text!]
            AF.request("\(self.defaults.object(forKey: "url") ?? "")pendiente", method: .post,parameters: parametros, encoding: URLEncoding.default,headers: headers).responseJSON{
                response in
                let JSON = response.result
                print(JSON)}
                self.performSegue(withIdentifier: "pendientes", sender: nil)
        }
         else{ alertDefault(with: "Error!!", andWith: "Todos los campos deben estar llenos")
            self.btnAceptar.shake()
            self.lblPendientes.shake()
            
         }
    }

    @IBAction func regresar(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pendientes", sender: nil)
    }
    
    
}
