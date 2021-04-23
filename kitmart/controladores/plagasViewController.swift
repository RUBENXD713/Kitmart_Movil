//
//  plagasViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 16/04/21.
//

import UIKit
import Alamofire

class plagasViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    
    var i=0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.i=0
        
        lbl1.round()
        lbl2.round()
        lbl3.round()
        lbl4.round()
        
        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
        let url = "\(defaults.object(forKey: "url")!)plagasAll"
        print(url)
        AF.request(url, method: .get,headers: headers).responseDecodable(of: [registroFinalSensor].self){ (response) in
            guard let pendientes = response.value else { return }
            
            /*self.lbl1.text = pendientes[0].valor
            self.lbl2.text = pendientes[1].valor
            self.lbl3.text = pendientes[2].valor
            self.lbl4.text = pendientes[3].valor*/
            
            for x in pendientes{
                self.i = self.i+1
                if self.i == 1{self.lbl1.text = x.valor}
                if self.i == 2{self.lbl2.text = x.valor}
                if self.i == 3{self.lbl3.text = x.valor}
                if self.i == 4{self.lbl4.text = x.valor}
                if self.i == 5{break}
            }
            self.i=0
        }

    }
}
