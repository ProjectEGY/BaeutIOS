//
//  BasketItemTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 21/07/2022.
//

import UIKit
import Kingfisher
class BasketItemTableViewCell: UITableViewCell {
    static let identifier = String(describing: BasketItemTableViewCell.self)
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var incrementItemButton: UIButton!
    @IBOutlet weak var decrementItemButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    func setUpBasketItems(basketItem:BasketItem){
        itemName.text = basketItem.name
        itemDescription.text = basketItem.basketItemDescription
        itemPrice.text = basketItem.price
        quantity.text = "\(basketItem.quantity!)"
        if let image = basketItem.image{
            let imageUrl = "\(Route.baseUrl)\(image)"
            itemImage.kf.setImage(with:imageUrl.asURL)
        }
    }
    
    
}
