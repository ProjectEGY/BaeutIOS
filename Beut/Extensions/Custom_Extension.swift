//
//  Custom.swift
//  Esfenja
//
//  Created by ProjectEgy on 05/07/2022.
//

import UIKit
class CustomForComplaints: UITextField{
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if Locale.current.languageCode == "ar"{
            return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
        }
            return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
        }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if Locale.current.languageCode == "ar"{
            return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
        }
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
    }

//override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//    if Locale.current.languageCode == "ar"{
//        return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
//    }
//    return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
//}
}
class CustomUITextField: UITextField {
   
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    let arabicPadding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            return bounds.inset(by: arabicPadding)
        }
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            return bounds.inset(by: arabicPadding)
        }
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            return bounds.inset(by: arabicPadding)
        }
        return bounds.inset(by: padding)
    }

}

class CustomForIcons: UITextField {
   var padding = 40
    
  
    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        if MOLHLanguage.currentAppleLanguage() == "ar"{
//            self.textAlignment = .left
//            padding = -40
//        }else{
//            self.textAlignment = .right
//            padding = 40
//        }
       
        return CGRect(x: bounds.origin.x + CGFloat(padding), y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
//            if MOLHLanguage.currentAppleLanguage() == "ar"{
//                self.textAlignment = .left
//                padding = -40
//            }else{
//                self.textAlignment = .right
//                padding = 40
//            }
            return CGRect(x: bounds.origin.x + CGFloat(padding), y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        if MOLHLanguage.currentAppleLanguage() == "ar"{
//            self.textAlignment = .left
//            padding = -40
//        }else{
//            self.textAlignment = .right
//            padding = 40
//        }
 
        return CGRect(x: bounds.origin.x + CGFloat(padding), y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}
