//
//  StoreSubCategoryCollectionViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 22/09/2022.
//

import UIKit
import Kingfisher
class StoreSubCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: StoreSubCategoryCollectionViewCell.self)

    @IBOutlet weak var addToBasketBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plausBtn: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var quantityValue = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.quantity.text = "\(quantityValue)"
    }

    func setUpProduct(product:ProductModel){
        if let image = product.images{
            let url = "\(Route.baseUrl)\(image[0])"
            self.img.kf.setImage(with:url.asURL)
        }
        if let price = product.singleOriginalPrice{
            self.price.text = price
            
        }
        if let name = product.name{
            self.name.text = name
        }
        if let desc = product.description{
            self.details.text = desc
        }
    }
}
