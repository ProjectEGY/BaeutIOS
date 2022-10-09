//
//  OpetionsTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 07/08/2022.
//

import UIKit

class OpetionsTableViewCell: UITableViewCell {

    static let identifier = String(describing: OpetionsTableViewCell.self)
  
    @IBOutlet weak var sizePrice: UILabel!
    @IBOutlet weak var radioButton: UIImageView!
    @IBOutlet weak var sizeName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.radioButton.image = UIImage(named: "selected")!
        } else {
            self.radioButton.image = UIImage(named: "circle")!
        }
    }
    
    func setUpOptions(options:Options){
        if let name = options.name, let price = options.price{
            sizeName.text = name
            sizePrice.text = "\(price)"
        }
        
    }
    
    func setUpSizes(size:Size){
        print("Fayed:\(size)")
        if let name = size.name, let price = size.originalPrice{
            sizeName.text = name
            sizePrice.text = "\(price)"
        }
        
    }
}
