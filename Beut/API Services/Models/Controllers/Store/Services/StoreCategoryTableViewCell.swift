//
//  StoreCategoryTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 07/08/2022.
//

import UIKit

class StoreCategoryTableViewCell: UITableViewCell {

    static let identifier = String(describing: StoreCategoryTableViewCell.self)
    
    @IBOutlet weak var storeCategoryNameLabel: UILabel!
    override var isSelected: Bool{
            didSet{
                if self.isSelected
                {
                    super.isSelected = true
                    self.categoryName.backgroundColor = UIColor(named: "EsfenjaColor")!
                    self.categoryName.tintColor = .white
                }
                else
                {
                    super.isSelected = false
                    self.categoryName.backgroundColor = .white
                    self.categoryName.tintColor = UIColor(named: "LinkColor")
                }
            }
        }

//    @IBOutlet weak var categoryName: UIButton!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryName: UIButton!
    
    func setUpStoreCategories(storeCategories:Categs){
        if let image = storeCategories.imageUrl{
            let imageURL = "\(Route.baseUrl)\(image)"
            self.categoryImage.kf.setImage(with: imageURL.asURL)
        }
        
        
        if home{
            self.categoryName.setTitle(storeCategories.name!, for: .normal)
        }
        
        storeCategoryNameLabel.text = storeCategories.name!
    }
    
    func setUpHomeCategories(homwCategories:Categories){
        let imageURL = "\(Route.baseUrl)\(homwCategories.imageURL!)"
        
        self.categoryImage.kf.setImage(with: imageURL.asURL)
        self.categoryName.setTitle(homwCategories.name, for: .normal)
    }
    

}
