//
//  RegistrarUsuarioViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 07/04/21.
//

import UIKit
import Alamofire

struct registrarUser:Decodable {
    let _id:String
    let email:String
    let password:String
    let created_at:String
    let updated_at:String
    
}

class RegistrarUsuarioViewController: UIViewController {

    
    @IBOutlet weak var lbCorreoE: UITextField!
    @IBOutlet weak var lbConstrasena1: UITextField!
    @IBOutlet weak var lbContrasena2: UITextField!
    @IBOutlet weak var btnRegistrar: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func RegistrarUsuario(_ sender: UIButton) {
        
        let headers:HTTPHeaders = [
            "Accept":"aplication/json"
        ]
        
        if lbCorreoE.text! != "" && lbConstrasena1.text! != "" && lbContrasena2.text! != "" {
            if lbConstrasena1.text! == lbContrasena2.text! {
                let parametros = ["email": lbCorreoE.text!,"password": lbConstrasena1.text!]
                AF.request("\(self.defaults.object(forKey: "url") ?? "")users", method: .post,parameters: parametros,headers: headers).responseDecodable(of: registrarUser.self){ (response) in
                    guard let registroExitoso = response.value else {
                        self.lbContrasena2.shake()
                        self.lbConstrasena1.shake()
                        self.lbCorreoE.shake()
                        self.alertDefault(with: "Error!!", andWith: "El correo no cumple con las caracteristicas de un email, utiliza solo minusculas,numeros,caracteres @ minusculas,numeros,caracteres")
                        return}
                    self.performSegue(withIdentifier: "registro-login", sender: nil)
                }
            }
            else{
                alertDefault(with: "Error!!", andWith: "La contraseña no coincide, verifica bien los datos")
                btnRegistrar.shake()
                lbCorreoE.shake()
                lbConstrasena1.shake()
                lbContrasena2.shake()
            }
        }
        else{
            alertDefault(with: "Error!!", andWith: "Todos los campos deben estar llenos")
            btnRegistrar.shake()
            lbCorreoE.shake()
            lbConstrasena1.shake()
            lbContrasena2.shake()
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
