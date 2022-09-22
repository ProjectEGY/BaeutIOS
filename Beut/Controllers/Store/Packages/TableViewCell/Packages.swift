//
//  Packages.swift
//  Esfenja
//
//  Created by ProjectEgy on 17/07/2022.
//

import UIKit
import Kingfisher
@available(iOS 13.0, *)
class Packages: UITableViewCell {

    @IBOutlet weak var doesHaveOffer: UIImageView!
    var packagesIndicator = PackagesViewController()
    @IBOutlet weak var productOfferPrice: UILabel!
    @IBOutlet weak var productOriginalPrice: UILabel!
    @IBOutlet weak var productInformation: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    static let identifier = String(describing: Packages.self)
    
    var products:ProductModel?
   
    private func addProductToBasket(body:[String:Any]){
        self.alpha = 0.5
            NetworkService.shared.addToBasket(body: body){
                [weak self] (result) in
                
                switch result{
                case .success( _):
                    self?.packagesIndicator.packagesIndicator.customIndicator(start: false)
                case.failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func setUpPackeges(productPakage:ProductModel){
        products = productPakage
        productName.text = productPakage.name!
        
        productInformation.text = productPakage.description
        
        
        if let isMultiple = productPakage.isMultipleSize, isMultiple == true{
            
            guard let sizes = productPakage.sizes else {return}
            guard let originalPrice = sizes[0].originalPrice else {return}
            print("Sizes:\(sizes)")
            productOriginalPrice.text = originalPrice
            
        }else{
            guard let price = productPakage.singleOriginalPrice else {return}
            productOriginalPrice.text = price
        }
        
        if let offerPrice = productPakage.singleOfferPrice, offerPrice != "" {
            
            let decimalCharacters = CharacterSet.decimalDigits

            let decimalRange = offerPrice.rangeOfCharacter(from: decimalCharacters)

            if decimalRange != nil {
                doesHaveOffer.isHidden = false
                productOfferPrice.isHidden = false
                productOfferPrice.text = offerPrice
            }else{
                doesHaveOffer.isHidden = true
                productOfferPrice.isHidden = true
            }
            
        }else{
            productOfferPrice.isHidden = true
        }
        
        
        if let images = productPakage.images{
            if images.count != 0{
                let imageUrl = "\(Route.baseUrl)\(images[0])"
                productImage.kf.setImage(with:imageUrl.asURL)
            }
           
        }
    }
}
