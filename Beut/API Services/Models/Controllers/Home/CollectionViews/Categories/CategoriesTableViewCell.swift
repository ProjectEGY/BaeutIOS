//
//  CategoriesTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 10/07/2022.
//

import UIKit
import Kingfisher
class CategoriesTableViewCell: UITableViewCell {
    static let identifier = String(describing: CategoriesTableViewCell.self)

    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var marketLocation: UILabel!
    @IBOutlet weak var marketRating: UILabel!
    @IBOutlet weak var marketDetails: UILabel!
    
    
    @IBOutlet weak var marketImage: UIImageView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    
    func setUpStoreCategory(storeCategory:StoreCategory){
        marketName.text = storeCategory.name!
        marketImage.kf.setImage(with: storeCategory.imageUrl!.asURL)
        marketRating.text = storeCategory.rate
        marketDetails.text = storeCategory.description
        marketLocation.text = "null"
    }

}
