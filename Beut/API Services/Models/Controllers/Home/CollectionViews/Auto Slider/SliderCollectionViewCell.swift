//
//  SliderCollectionViewCell.swift
//  Esfenja
//
//  Created by ProjectEgy on 28/06/2022.
//

import UIKit
import Kingfisher
class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgSliderPhoto: UIImageView!
    
    func setUpSlider(data:SingleSlide){
        if let image = data.image{
            let imageFullUrl = "\(Route.baseUrl)\(image)"
            self.imgSliderPhoto.kf.setImage(with:imageFullUrl.asURL)
        }
        
    }
}
