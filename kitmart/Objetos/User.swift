//
//  User.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 07/04/21.
//

/*import UIKit

class User: NSObject {
    var email:String!
    var token:String!
    
    init(_ email:String, _ token:String) {
        self.token = token
        self.email = email
    }
    
    func guardar(){
        do{
            App_User.shared.user = User
            let encoder = JSONEncoder()
            let data = try
                encoder.encode(App_User.shared.user)
            App_User.shared.defaults.set(data, forKey: "user")
            App_User.shared.defaults.synchronize()
            print(App_User.shared.defaults)
        }
    }
    
    func eliminar(){
        App_User.shared.user = {}
        print(App_User.shared.user)
    }
}*/
