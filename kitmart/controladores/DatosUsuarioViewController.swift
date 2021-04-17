//
//  DatosUsuarioViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 15/04/21.
//

import UIKit
import Alamofire

struct UserDates:Decodable {
    let _id: String
    let email: String
    let password: String
    let created_at: String
    let updated_at: String
}

class DatosUsuarioViewController: UIViewController {
    
    @IBOutlet weak var cerrarSesion: UIButton!
    @IBOutlet weak var lblDatos: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        cerrarSesion.round()
        
        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
       
        let url = "\(defaults.object(forKey: "url")!)usuario"
        print(url)
        AF.request(url, method: .get,headers: headers).responseDecodable(of: UserDates.self){ (response) in
            guard let user = response.value else { return }
            self.lblDatos.text = user.email
            
            }
        
        }
    
    @IBAction func cerrarSesion(_ sender: UIButton) {
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
        self.performSegue(withIdentifier: "CerrarSesion", sender: nil)
    }
    
    @IBAction func Creditos(_ sender: Any) {
        self.performSegue(withIdentifier: "", sender: nil)
    }
    
}
