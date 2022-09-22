//
//  UIViewController_Extension.swift
//  Esfenja
//
//  Created by ProjectEgy on 08/07/2022.
//

import UIKit

@available(iOS 13.0, *)
extension UIViewController{
    static var identifier:String{
        return String(describing: self)
    }
    static func instantiate(storyboardName:String)->Self{
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    /// This function disable user interaction with cureent view when there is a proccessing task util it's finished
    /// - Parameter wannaMakeItVisible: a boolean
    public func makeViewInVisible(wannaMakeItVisible:Bool){
        if wannaMakeItVisible{
//            self.view.alpha = 0.7
            self.view.isUserInteractionEnabled = false
        }else{
//            self.view.alpha = 1
            self.view.isUserInteractionEnabled = true
        }
        
    }
    /// Alert view
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: The message you wanna show
    public func showInofToUser(title:String = "Information", message:String){
        AlertView.showAlertBox(title: title.localized, message: message.localized) { action in
                    // Okay action code
        }.present(on: self) {}
    }
}

protocol Presentable{
    
}

@available(iOS 13.0, *)
extension Presentable{
    public func showInofToUser(title:String = "Information", message:String){
        AlertView.showAlertBox(title: title.localized, message: message.localized) { action in
                    // Okay action code
        }.present(on: self as! UIViewController) {}
    }
}
