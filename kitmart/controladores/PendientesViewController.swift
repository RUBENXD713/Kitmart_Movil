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
    let estado: Int
    let updated_at: String
    let userId: String
    
}

struct ResponsePendiente:Decodable {
    let data: [Pendiente]
}

class PendientesViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var pendiente1: UILabel!
    @IBOutlet weak var pendiente2: UILabel!
    @IBOutlet weak var pendiente3: UILabel!
    @IBOutlet weak var pendiente4: UILabel!
    @IBOutlet weak var pendiente5: UILabel!
    
    @IBOutlet weak var viewPendientes: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        pendiente1.round()
        pendiente2.round()
        pendiente3.round()
        pendiente4.round()
        pendiente5.round()
        
        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
        let url = "\(defaults.object(forKey: "url")!)pendientesUsuario"
        print(url)
        AF.request(url, method: .get,headers: headers).responseDecodable(of: [Pendiente].self){ (response) in
            guard let pendientes = response.value else { return }
            print(pendientes.first ?? [Pendiente]())
            
            self.pendiente1.text = pendientes[0].descripcion
            self.pendiente2.text = pendientes[1].descripcion
            self.pendiente3.text = pendientes[2].descripcion
            self.pendiente4.text = pendientes[3].descripcion
            self.pendiente5.text = pendientes[4].descripcion
            
            pendientes.forEach { (pendiente) in
            }
            //for x in pendientes{
               // print(x.descripcion)
           // }
            //guard let pendientes = response.value else { return }
            
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
