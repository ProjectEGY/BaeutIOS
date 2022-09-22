//
//  UIImageView_Extensions.swift
//  Esfenja
//
//  Created by ProjectEgy on 15/07/2022.
//

import Foundation
import UIKit


extension UIImageView{
    public func makeImageCircular(anyImage:UIImage){
        self.contentMode = UIView.ContentMode.scaleAspectFill
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.masksToBounds = false
            self.clipsToBounds = true
            self.image = anyImage
    }
}
