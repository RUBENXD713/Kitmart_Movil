//
//  MenuDropViewController.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 24/03/21.
//

//import DropDown
import UIKit

class MenuDropViewController: UIViewController {

    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
        "Item 1",
            "Item 1",
            "Item 1"]
        
        return menu()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let myView = UIView(frame: navigationController?.navigationBar.frame ?? .zero)
        navigationController?.navigationBar.topItem?.titleView = myView
        guard let topView = navigationController?.navigationBar.topItem?.titleView else {
            return
            
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        topView.addGestureRecognizer(gesture)
    }
    @objc func didTapTopItem(){
        
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
