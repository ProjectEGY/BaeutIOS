//
//  SubCategoriesTableViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 21/09/2022.
//

import UIKit
import AARatingBar
import Kingfisher
class SubCategoriesTableViewCell: UITableViewCell {

    static let identifier = String(describing: SubCategoriesTableViewCell.self)
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var SImage: UIImageView!
    
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var rate: AARatingBar!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpSubCategories(category:SubCategoryModel){
        if let name = category.name{
            self.name.text = name
        }
        if let address = category.address{
            self.address.text = address
        }
        if let image = category.imageUrl{
            let url = "\(Route.baseUrl)\(image)"
            self.SImage.kf.setImage(with:url.asURL)
            
        }
        if let desc = category.description{
            self.details.text = desc
        }
        if let rate = category.rate{
            self.rate.isEnabled = false
            if let n = NumberFormatter().number(from: rate) {
                let num = CGFloat(truncating: n)
                self.rate.value = num
                if num > 0{
                    self.rate.color = .systemYellow
                }else{
                    self.rate.color = .gray
                }
                
            }
        }
    }
    
}
