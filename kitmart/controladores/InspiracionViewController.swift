//
//  InspiracionViewController.swift
//  kitmart
//
//  Created by mac15 on 26/03/21.
//

import UIKit
import Alamofire

class InspiracionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSArray?
    var nombreArray: Array<String> =  []
    var imagenURLArray: Array<String> =  []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        downloadDataFromApi()
        // Do any additional setup after loading the view.
    }
    
    func downloadDataFromApi(){
        //1.
           AF.request("http://private-5d2b9-efectoapplepokemonapp.apiary-mock.com/pokemonList") .responseJSON { response in
              //2.
            if let JSON = response.value{
                 //3.
                 self.jsonArray = JSON as? NSArray
                 //4.
                 for item in self.jsonArray! as! [NSDictionary]{
                    //5.
                    let name = item["name"] as? String
                    let imageURL = item["image"] as? String
                    self.nombreArray.append((name)!)
                    self.imagenURLArray.append((imageURL)!)
                 }
                 //6.
                 self.tableView.reloadData()
         
              }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombreArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InspiracionTableViewCell
        
        celda.nombreCelda.text = self.nombreArray [indexPath.row]
        
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
}
