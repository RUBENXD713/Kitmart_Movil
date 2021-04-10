//
//  Inspiracion.swift
//  kitmart
//
//  Created by Ruben Hernandez Diaz on 07/04/21.
//

import UIKit

class Inspiracion: UITableViewCell {

    @IBOutlet weak var nombreCelda: UILabel!
    @IBOutlet weak var ingredienteCelda: UILabel!
    @IBOutlet weak var infoCelda: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
