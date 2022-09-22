//
//  StoreCategoryTableViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 18/07/2022.
//

import UIKit
import AARatingBar
class StoreCategoryTableViewCell: UITableViewCell {

    static let identifier = String(describing: StoreCategoryTableViewCell.self)

    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var marketLocation: UILabel!
    @IBOutlet weak var marketDetails: UILabel!
    @IBOutlet weak var marketImage: UIImageView!
    
    @IBOutlet weak var ratingValue: AARatingBar!
    
    func setUpStoreCategory(storeCategory:StoreCategory){
        if let image = storeCategory.imageUrl{
            let imageURL = "\(Route.baseUrl)\(image)"
            marketImage.kf.setImage(with: imageURL.asURL)
        }
       
        marketName.text = storeCategory.name
        
        marketDetails.text = storeCategory.description
        marketLocation.text = storeCategory.address
        
        ratingValue.color = .gray
        ratingValue.isEnabled = false
        if let n = NumberFormatter().number(from: storeCategory.rate!) {
            ratingValue.value = CGFloat(truncating: n)
        }
    }
    
    
    func setStoreSearchResult(searchResult:SearchResult){
        if let image = searchResult.imageURL{
            let imageURL = "\(Route.baseUrl)\(image)"
            marketImage.kf.setImage(with: imageURL.asURL)
        }
        
        marketName.text = searchResult.nameEn
        
        marketDetails.text = searchResult.searchDescription
        marketLocation.text = searchResult.address
    }
    
}
