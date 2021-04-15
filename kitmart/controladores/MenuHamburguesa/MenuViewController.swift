//
//  MenuViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 13/04/21.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController {

    var menu : SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
    }
}
class MenuListController: UITableViewController{
    var items = ["First", "Second", "Third", "First", "Second", "Third"]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableView.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int
    {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
}
