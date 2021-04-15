//
//  Post.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 14/04/21.
//

import UIKit

class Post: Codable {
    var _id: String
    var nombre: String
    var preparacion: String
    var userId: String
    var created_at: String
    var updated_at: String
    
    init(_id: String, nombre: String, preparacion: String, userId: String, created_at: String, updated_at: String) {
        self._id = _id
        self.nombre = nombre
        self.preparacion = preparacion
        self.userId = userId
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    static func all(_ observable:IPost){
        let session = URLSession.shared
        let url = URL(string: "http://127.0.0.1:3333/recetas")!
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error ?? "Error en el request")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data!)
                observable.onGettingAllPosts(posts: posts)
            }catch{
                print("No fue posible la decodificacion")
            }
            
            print(response!)
        }
        task.resume()
    
    }
}
