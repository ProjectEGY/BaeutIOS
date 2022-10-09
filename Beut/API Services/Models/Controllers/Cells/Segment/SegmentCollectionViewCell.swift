//
//  SegmentCollectionViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 22/09/2022.
//

import UIKit

class SegmentCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: SegmentCollectionViewCell.self)
    
    @IBOutlet weak var categoryName:UILabel!
    
    override var isSelected: Bool{
            didSet{
                if self.isSelected
                {
                    super.isSelected = true
                    self.categoryName.backgroundColor = UIColor(named: "MainColor")!
                    self.categoryName.textColor = .white
                }
                else
                {
                    super.isSelected = false
                    self.categoryName.backgroundColor = .white
                    self.categoryName.textColor = UIColor(named: "LinkColor")
                }
            }
        }
    
    func setUpCategoryName(name:String?){
        if let name = name {
            self.categoryName.text = name
        }
        
    }
}
