//
//  ItemDetailsTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 26/07/2022.
//

import UIKit
import Kingfisher
class ItemDetailsTableViewCell: UITableViewCell {

    static let identifier = String(describing: ItemDetailsTableViewCell.self)
    
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func setUpItemDetails(item:BasketItem){
        itemPrice.text = item.price
        itemName.text = item.name
        itemDescription.text = item.basketItemDescription
        itemQuantity.text = "\(item.quantity!)"
        if let image = item.image{
            let imageUrl = "\(Route.baseUrl)\(image)"
            itemImage.kf.setImage(with:imageUrl.asURL)
        }
    }
    
}
