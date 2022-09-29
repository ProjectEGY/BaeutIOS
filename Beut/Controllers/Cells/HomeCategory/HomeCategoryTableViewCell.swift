//
//  HomeCategoryTableViewCell.swift
//  Beut
//
//  Created by ProjectEgy on 20/09/2022.
//

import UIKit
import Kingfisher
class HomeCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var customView: UIView!
    static let identifier = String(describing: HomeCategoryTableViewCell.self)
   
    let myGradiant = CAGradientLayer()
    override func layoutSubviews() {
        super.layoutSubviews()

        myGradiant.frame = self.customView.bounds
        myGradiant.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]

        self.customView.layer.insertSublayer(myGradiant, at: 0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCategory(category:Categories) {
        print("Category:\(category)")
        if let name = category.name{
            self.catName.text = name
        }
        if let image = category.imageURL{
            let url = "\(Route.baseUrl)\(image)"
            self.catImage.kf.setImage(with:url.asURL)
        }
    }
}
