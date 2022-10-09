//
//  StoreCategoriesCollectionViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 21/09/2022.
//

import UIKit
import Kingfisher
class StoreCategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: StoreCategoriesCollectionViewCell.self)
    @IBOutlet weak var categoryName:UILabel!
    @IBOutlet weak var categoryImage:UIImageView!
    
    
    func setUpStoreCategories(category:Categs){
        if let name = category.name{
            self.categoryName.text = name
        }
        if let image = category.imageUrl{
            let url = "\(Route.baseUrl)\(image)"
            self.categoryImage.kf.setImage(with:url.asURL)
        }
    }
}
