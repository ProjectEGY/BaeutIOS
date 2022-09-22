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

override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    if Locale.current.languageCode == "ar"{
        return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
    }
    return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y + 15, width: bounds.width, height: bounds.height)
}
}
class Custom: UITextField {
   
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if Locale.current.languageCode == "ar"{
            return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
            return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            if Locale.current.languageCode == "ar"{
                return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
            }
            return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if Locale.current.languageCode == "ar"{
            return CGRect(x: bounds.origin.x - 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

}

class CustomForIcons: UITextField {
   var padding = 0
  
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        if Locale.current.languageCode == "ar"{
            padding = -40
        }else{
            padding = 40
        }
        return CGRect(x: bounds.origin.x + CGFloat(padding), y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            if Locale.current.languageCode == "ar"{
                padding = -40
            }else{
                padding = 40
            }
            return CGRect(x: bounds.origin.x + CGFloat(padding), y: bounds.origin.y, width: bounds.width, height: bounds.height)
        }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if Locale.current.languageCode == "ar"{
            padding = -40
        }else{
            padding = 40
        }
        return CGRect(x: bounds.origin.x + CGFloat(padding), y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}
