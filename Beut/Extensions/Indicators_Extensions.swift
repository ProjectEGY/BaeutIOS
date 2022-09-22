//
//  Indicators_Extensions.swift
//  Esfenja
//
//  Created by ProjectEgy on 15/07/2022.
//

import Foundation
import NVActivityIndicatorView


extension NVActivityIndicatorView{
   
    public func customIndicator(start:Bool, type:NVActivityIndicatorType? = .circleStrokeSpin, color:UIColor? = .blue){
        self.isHidden = !start
        if start{
            if let type = type, let color = color{
                self.type = type
                self.color = color
            }
            self.startAnimating()
        }else{
            self.stopAnimating()
        }
    }
}
