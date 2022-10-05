//
//  UILabel+Extenstion.swift
//  Beut
//
//  Created by ProjectEgy on 05/10/2022.
//

import Foundation
import UIKit
extension UILabel{
    public func drawDiagonalLine(){
        let red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        let v = ViewWithDiagonalLine()
        v.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        v.layer.borderColor = red.cgColor
        v.layer.borderWidth = 0
        self.addSubview(v)
    }
}
