//
//  OffersCollectionViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 25/09/2022.
//

import UIKit
import Kingfisher
class OffersCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: OffersCollectionViewCell.self)

    @IBOutlet weak var addToBasketBtn: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plausBtn: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var img: UIImageView!
    var quantityValue = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        self.quantity.text = "\(self.quantityValue)"
        self.price.drawDiagonalLine()
            if #available(iOS 13.0, *) {
                self.addToBasketBtn.text = "AddToBasket".localized
            } else {
                self.addToBasketBtn.text = NSLocalizedString("AddToBasket", comment: "")
            }
        
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
        if let storeName = product.storeName{
            self.storeName.text = storeName
        }
        if let offerPrice = product.singleOfferPrice{
            self.offerPrice.text = "\(offerPrice)"
        }
        
        guard let isMultiple = product.isMultipleSize, isMultiple == true else {return}
        guard let sizes = product.sizes, sizes.count > 0 else {return}
        if let firstOriginalPrice = sizes[0].originalPrice {
            self.price.text = firstOriginalPrice
        }
        if let firstOfferPrice = sizes[0].offerPrice {
            self.offerPrice.text = firstOfferPrice
        }
    }

}
