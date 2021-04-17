//
//  estufaViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 16/04/21.
//

import UIKit
import Alamofire

class estufaViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl1.round()
        lbl2.round()
        lbl3.round()
        lbl4.round()
        
        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
        let url = "\(defaults.object(forKey: "url")!)plagas"
        print(url)
        AF.request(url, method: .get,headers: headers).responseDecodable(of: [registroFinalSensor].self){ (response) in
            guard let pendientes = response.value else { return }
            print(pendientes.first ?? [registroFinalSensor]())
            
            self.lbl1.text = pendientes[0].valor
            self.lbl2.text = pendientes[1].valor
            self.lbl3.text = pendientes[2].valor
            self.lbl4.text = pendientes[3].valor
            
        }

    }

}
