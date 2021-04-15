//
//  Item.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 14/04/21.
//

import UIKit

class Item: UIView {

    var title: UILabel?
    var body: UITextView?
    
    func build(_ post:Post){
        self.backgroundColor = UIColor(named: "ItemColor")
        title = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.width-10, height: self.frame.height/3))
        title?.text = post.nombre.uppercased()
        title?.font = UIFont(name: "Arial Bold", size: 14.0)
        title?.textAlignment = .center
        body = UITextView(frame: CGRect(x: 15, y: self.frame.height/3, width: self.frame.width, height: (self.frame.height/3)*2-10))
        body?.text = post.preparacion
        body?.backgroundColor = UIColor(named: "ItemColor")
        
        self.addSubview(title!)
        self.addSubview(body!)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

