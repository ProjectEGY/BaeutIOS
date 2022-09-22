//
//  Fonts.swift
//  Esfenja
//
//  Created by ProjectEgy on 16/08/2022.
//

import Foundation
import UIKit

struct Tajawal {
    static let bold = "Tajawal-Light"
    static let regular = "Tajawal-Medium"
}

extension UIFontDescriptor.AttributeName {
  static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {

  @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name:  Tajawal.regular, size: size)!
  }

//  @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name:  Tajawal.bold, size: size)!
//  }

//  @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name:  Tajawal.lightAlt, size: size)!
//  }

  @objc convenience init(myCoder aDecoder: NSCoder) {
    guard
        let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
        let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
        self.init(myCoder: aDecoder)
        return
    }
    var fontName = ""
    switch fontAttribute {
    case "CTFontRegularUsage":
        fontName =  Tajawal.regular
    case "CTFontEmphasizedUsage", "CTFontBoldUsage":
        fontName =  Tajawal.bold
//    case "CTFontObliqueUsage":
//        fontName =  Tajawal.lightAlt
    default:
        fontName =  Tajawal.regular
    }
    self.init(name: fontName, size: fontDescriptor.pointSize)!
  }

  class func overrideInitialize() {
    guard self == UIFont.self else { return }

    if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
        let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
        method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
    }

//    if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
//        let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
//        method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//    }

//    if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
//        let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
//        method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//    }

    if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
        let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
        method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
    }
  }
}
