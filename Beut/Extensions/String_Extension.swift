//
//  String+Extension.swift
//  Esfenja
//
//  Created by ProjectEgy on 29/06/2022.
//

import Foundation
import UIKit
extension String{
    var asURL:URL?{
        return URL(string: self)
    }
    var localized:String{
        return NSLocalizedString(self, comment: "")
    }
}

extension Date{
    func dateAsString()->String{
        let date = DateFormatter()
        date.dateFormat = "dd-MM-yyyy"
        return date.string(from: self)
    }
    func timeAsString()->String{
        let date = DateFormatter()
        date.dateFormat = "HH:mm:ss"
        return date.string(from: self)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}


