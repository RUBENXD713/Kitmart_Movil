//
//  AgregarRecetaViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 09/04/21.
//

import UIKit
import Alamofire

class AgregarRecetaViewController: UIViewController {

    
    @IBOutlet weak var lbNombre: UITextField!
    @IBOutlet weak var lbIngredientes: UITextField!
    @IBOutlet weak var lbDescripcion: UITextField!
    @IBOutlet weak var btnEnviar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func EnviarReceta(_ sender: Any) {
        let headers:HTTPHeaders = [
            "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MDY3ZGJkZTI3NzJkZDM1MzRhYjUyYjMiLCJpYXQiOjE2MTgwMDk1MDJ9.oyXHyJoVFrMNrh6oUDqwJ5_C7UnzowBcfKGTw-35Jw0",
            "Accept":"aplication/json"
        ]
        if lbNombre.text! != "" && lbDescripcion.text! != "" && lbIngredientes.text! != "" {
            let parametros = ["nombre": lbNombre.text!,"ingredientes":lbIngredientes.text!,"preparacion": lbDescripcion.text!]
            AF.request("http://192.168.1.77:3333/api/receta", method: .post,parameters: parametros, encoding: URLEncoding.default,headers: headers).responseJSON{
                response in
                let JSON = response.result
                
                print(JSON)}
            lbNombre.text! = ""
            lbIngredientes.text! = ""
            lbDescripcion.text! = ""
            
        }
         else{ alertDefault(with: "Error!!", andWith: "Todos los campos deben estar llenos")
            self.btnEnviar.shake()
            self.lbNombre.shake()
            self.lbIngredientes.shake()
            self.lbDescripcion.shake()
            
         }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
