//
//  OnBoardingCollectionViewCell.swift
//  Market - ماركت
//
//  Created by ProjectEgy on 13/09/2022.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnBoardingCollectionViewCell.self)
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var descLbl2: UILabel!
    
    func setUpOnBoardingInfo(info:OnBoardInfo){
        self.myImage.image = info.image
        self.descLbl.text = info.description
        self.descLbl2.text = info.description2
    }
}
