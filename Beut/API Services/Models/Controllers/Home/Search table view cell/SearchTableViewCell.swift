//
//  SearchTableViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 25/09/2022.
//

import UIKit
import Kingfisher
class SearchTableViewCell: UITableViewCell {
    static let identifier = String(describing: SearchTableViewCell.self)

    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var originalPrice:UILabel!
    @IBOutlet weak var offerPrice:UILabel!
    @IBOutlet weak var details:UILabel!
    @IBOutlet weak var quantity:UILabel!
    @IBOutlet weak var addToBasket:UILabel!
    @IBOutlet weak var plusBtn:UIButton!
    @IBOutlet weak var minusBtn:UIButton!
    var quantityValue = 1
    override func awakeFromNib() {
        self.quantity.text = "\(self.quantityValue)"
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            self.addToBasket.text = "AddToBasket".localized
        } else {
            self.addToBasket.text = NSLocalizedString("AddToBasket", comment: "")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpSearchResult(result:ProductModel){
        
      
        if let image = result.images{
            if image.count > 0{
                let url = "\(Route.baseUrl)\(image[0])"
                self.img.kf.setImage(with:url.asURL)
            }
           
        }
        
        if let name = result.name{
           
                self.name.text = name
        }
        
        if let desc = result.description{
            self.details.text = desc
        }
        
        if let originalPrice = result.singleOriginalPrice{
            self.originalPrice.text = originalPrice
        }
        
        if let offerPrice = result.singleOfferPrice, offerPrice != "" {
            
            let decimalCharacters = CharacterSet.decimalDigits

            let decimalRange = offerPrice.rangeOfCharacter(from: decimalCharacters)

            if decimalRange != nil {
                originalPrice.drawDiagonalLine()
                self.offerPrice.isHidden = false
                self.offerPrice.text = offerPrice
            }else{
                self.offerPrice.isHidden = true
            }
            
        }else{
            self.offerPrice.isHidden = true
        }
        
        
    }

}
