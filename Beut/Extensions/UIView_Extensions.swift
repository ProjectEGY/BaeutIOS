//
//  UIView_Extensions.swift
//  Esfenja
//
//  Created by ProjectEgy on 22/06/2022.
//

import UIKit

extension UIView{

    @IBInspectable
    var cornerRaduis:CGFloat{
        get {

            return self.cornerRaduis
        }

        set {

            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var masksToBounds:Bool{

            get{
                return self.layer.masksToBounds
            }
            set{
                self.layer.masksToBounds = newValue
            }
    }
    @IBInspectable
    var borderWidth:CGFloat{
        get {

            return self.borderWidth
        }

        set {

            self.layer.borderWidth = newValue
        }
    }
    //Shadow set up
    @IBInspectable
    var shadowColor:UIColor{
        get {

            return self.shadowColor
        }

        set {

            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity:CGFloat{
        get {

            return self.shadowOpacity
        }

        set {

            self.layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable
    var shadowOffset:CGSize{
        get {

            return self.shadowOffset
        }

        set {

            self.layer.shadowOffset = .zero
        }
    }
    
    @IBInspectable
    var shadowRadius:CGFloat{
        get {

            return self.shadowRadius
        }

        set {

            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor:UIColor{
        get {

            return self.borderColor
        }

        set {

            self.layer.borderColor = newValue.cgColor
        }
    }
    var paddingLeft:CGFloat{
        get {

            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
