//
//  CategoriesCollectionViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 29/06/2022.
//

import UIKit
import Kingfisher
class CategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CategoriesCollectionViewCell.self)
    
    @IBOutlet weak var storeCategoryNameLabel: UILabel!
    override var isSelected: Bool{
            didSet{
                if self.isSelected
                {
                    super.isSelected = true
                    self.storeCategoryNameLabel.backgroundColor = UIColor(named: "EsfenjaColor")!
                    self.storeCategoryNameLabel.textColor = .white
                }
                else
                {
                    super.isSelected = false
                    self.storeCategoryNameLabel.backgroundColor = .white
                    self.storeCategoryNameLabel.textColor = UIColor(named: "LinkColor")
                }
            }
        }

//    @IBOutlet weak var categoryName: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
  
    
    func setUpHomeCategories(homwCategories:Categories){
//        storeCategoryNameLabel.layer.backgroundColor  = .blue
//        storeCategoryNameLabel.layer.cornerRadius = 5
//        storeCategoryNameLabel.layer.masksToBounds = true
        if let image = homwCategories.imageURL{
            let imageURL = "\(Route.baseUrl)\(image)"
            self.categoryImage.kf.setImage(with: imageURL.asURL)
        }
       
        
        
        self.storeCategoryNameLabel.text = homwCategories.name
    }
    
}
