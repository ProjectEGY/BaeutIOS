//
//  SizesTableViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 28/09/2022.
//

import UIKit

class SizesTableViewCell: UITableViewCell {

    static let identifier = String(describing: SizesTableViewCell.self)
    @IBOutlet weak var sizeName:UILabel!
    @IBOutlet weak var sizePrice:UILabel!
    @IBOutlet weak var sizeRadioButton:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.sizeRadioButton.image = UIImage(named: "tick2")!
        } else {
            self.sizeRadioButton.image = UIImage(named: "circle2")!
        }
    }
    
    func setUpSize(size:Size){
        if let name = size.name{
            self.sizeName.text = name
        }
        if let price = size.offerPrice{
            self.sizePrice.text = price
        }else{
            if let originalPrice = size.originalPrice{
                self.sizePrice.text = originalPrice
            }
        }
       
    }

}
