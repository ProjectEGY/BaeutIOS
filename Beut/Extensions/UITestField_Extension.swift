//
//  UITestField_Extension.swift
//  Esfenja
//
//  Created by ProjectEgy on 03/08/2022.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension UITextField{
    
    public func addLeftImage(image:UIImage){
        var smallIcon:UIImageView!
        if MOLHLanguage.currentAppleLanguage() == "en"{
            self.leftViewMode = .always
            smallIcon = UIImageView(frame: CGRect(x: 12, y: self.frame.height / 2 - 12, width: 20, height: 25))
        }else{
            self.textAlignment = .right
            self.makeTextWritingDirectionRightToLeft(nil)
            self.rightViewMode = .always
            smallIcon = UIImageView(frame: CGRect(x: self.frame.width - 30, y: self.frame.height / 2 - 12, width: 20, height: 25))
        }
        smallIcon.image = image
        self.addSubview(smallIcon)
    }
    public func handleArabicLanguage(){
        if MOLHLanguage.currentAppleLanguage() == "ar"{
                self.textAlignment = .right
                self.makeTextWritingDirectionRightToLeft(nil)
            }
    }
    
//        self.makeTextWritingDirectionRightToLeft(nil)
    
}
