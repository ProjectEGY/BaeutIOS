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
    static let identifier = String(describing: HomeCategoryTableViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
