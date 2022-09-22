//
//  UIAlertController_Extension.swift
//  Esfenja
//
//  Created by ProjectEgy on 13/07/2022.
//

import Foundation
import UIKit

extension UIAlertController{
    func showValidationAlertView(message:String){
        let myAlret = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        myAlret.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(myAlret, animated: true, completion: nil)
    }
}
