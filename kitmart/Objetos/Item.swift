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
    var body2: UITextView?
    
    func build(_ post:Post){
        self.backgroundColor = UIColor(named: "ItemColor")
        title = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.width-10, height: self.frame.height/3))
        title?.text = post.nombre.uppercased()
        title?.font = UIFont(name: "Arial Bold", size: 14.0)
        title?.textAlignment = .center
        body = UITextView(frame: CGRect(x: 15, y: self.frame.height/6, width: self.frame.width-20, height: (self.frame.height/3)*2-10))
        body?.text = "Ingredientes: \(post.ingredientes)"
        body?.backgroundColor = UIColor(named: "ItemColor")
        body2 = UITextView(frame: CGRect(x: 15, y: self.frame.height/2, width: self.frame.width-20, height: (self.frame.height/3)*2-10))
        body2?.text = "Preparacion: \(post.preparacion)"
        body2?.backgroundColor = UIColor(named: "ItemColor")
        
        self.addSubview(title!)
        self.addSubview(body!)
        self.addSubview(body2!)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

