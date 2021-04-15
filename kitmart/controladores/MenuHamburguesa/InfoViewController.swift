//
//  InfoViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 14/04/21.
//

import UIKit
import Alamofire

struct Dates:Decodable {
    let _id: String?
    let email: String
    let password: String
    let created_at: String
    let updated_at: String

}

class InfoViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var txtDatos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers:HTTPHeaders = [
            "Authorization":"Bearer \(defaults.object(forKey: "token") ?? "")",
            "Accept":"aplication/json"
        ]
        
        AF.request("\(self.defaults.object(forKey: "url") ?? "")usuario", method: .post,headers: headers).responseDecodable(of: Dates.self){ (response) in
                
            guard let user = response.value else { return }
            print(user)
        

        // Do any additional setup after loading the view.
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
    
}


