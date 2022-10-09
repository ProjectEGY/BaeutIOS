//
//  StoreCategoryCollectionViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 07/08/2022.
//

import UIKit

class StoreCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: StoreCategoryCollectionViewCell.self)
    
    @IBOutlet weak var storeCategoryNameLabel: UILabel!
//    override var isSelected: Bool{
//            didSet{
//                if self.isSelected
//                {
//                    super.isSelected = true
//                    self.categoryName.backgroundColor = UIColor(named: "EsfenjaColor")!
//                    self.categoryName.tintColor = .white
//                }
//                else
//                {
//                    super.isSelected = false
//                    self.categoryName.backgroundColor = .white
//                    self.categoryName.tintColor = UIColor(named: "LinkColor")
//                }
//            }
//        }

//    @IBOutlet weak var categoryName: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
        
    func setUpStoreCategories(storeCategories:Categs){
        if let image = storeCategories.imageUrl{
            let imageURL = "\(Route.baseUrl)\(image)"
            self.categoryImage.kf.setImage(with: imageURL.asURL)
        }
        storeCategoryNameLabel.text = storeCategories.name!
    }
    
   
}
