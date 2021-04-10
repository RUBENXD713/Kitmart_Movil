//
//  InspiracionViewController.swift
//  kitmart
//
//  Created by mac15 on 26/03/21.
//

import UIKit
import Alamofire

class InspiracionViewController: UIViewController//, UITableViewDelegate, UITableViewDataSource
{
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSArray?
    var nombreArray: Array<String> =  []
    var ingredientesArray: Array<String> = []
    var procedimientoArray: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        downloadDataFromApi()
        // Do any additional setup after loading the view.
    }
    
    func downloadDataFromApi(){
        //1.
           AF.request("https://test-es.edamam.com/search?q=chicken&app_id=5cf4635d&app_key=ee7dc9acb37f13136478a1683b31cc00") .responseJSON { response in
              //2.
            if let JSON = response.value{
                 //3.
                 self.jsonArray = JSON as? NSArray
                 //4.
                 for item in self.jsonArray! as! [NSDictionary]{
                    //5.
                    let name = item["label"] as? String
                    self.nombreArray.append((name)!)
                    let ingre = item["ingredientLines"]as? String
                    self.ingredientesArray.append((ingre)!)
                    let proc = item["url"]as? String
                    self.procedimientoArray.append((proc)!)
                    
                    
                    self.tableView.reloadData()
         
              }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Inspiracion
        
        celda.nombreCelda.text = self.nombreArray [indexPath.row]
        celda.ingredienteCelda.text = self.ingredientesArray [indexPath.row]
        celda.infoCelda.text = self.procedimientoArray[indexPath.row]
        //let url = URL(string: self.imagenURLArray[indexPath.row])
        //celda.imagenCelda.
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        return height/3
    }

    }
}*/
}
