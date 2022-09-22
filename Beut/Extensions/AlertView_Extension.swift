//
//  AlertView_Extension.swift
//  Esfenja
//
//  Created by ProjectEgy on 26/07/2022.
//

import Foundation
import UIKit
@available(iOS 13.0, *)
struct AlertView {
    public static func showAlertBox(title: String, message: String, handler: ((UIAlertAction)->Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .cancel, handler: handler))
        return alert
    }
}

extension UIAlertController {
    func present(on viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: true, completion: completion)
    }
}
