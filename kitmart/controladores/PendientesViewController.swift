//
//  PendientesViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 14/04/21.
//

import UIKit
import Alamofire

struct Pendiente:Decodable {
    let _id: String
    let created_at: String
    let descripcion: String
    let estado: String
    let updated_at: String
    let userId: String
    
}

struct ResponsePendiente:Decodable {
    let data: [Pendiente]
}

class PendientesViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var viewPendientes: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
        
        AF.request("\(self.defaults.object(forKey: "url") ?? "")pendientesUsuario", method: .get,headers: headers).responseDecodable(of: [Pendiente].self){ (response) in
            let pendientes = response.value
            
            //for x in pendientes{
               // print(x.descripcion)
           // }
            //guard let pendientes = response.value else { return }
            print(pendientes as Any? ?? "")
            }
        
        /*let tableView = UITableView(frame: view.bounds )
        tableView.addSubview(tableView)
        
        view.addSubview(tableView)*/
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        return cell
    }
    
}
