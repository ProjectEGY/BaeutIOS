//
//  TermsConditions.swift
//  Esfenja
//
//  Created by ProjectEgy on 08/08/2022.
//

import UIKit
import WebKit
class TermsConditions: UIViewController {

    @IBOutlet weak var TermsConditions: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("TermsandConditions", comment: "Terms and conditions")
        guard let url = URL(string: "\(Route.baseUrl)/TermsAndConditions/user") else{
            return
        }
        TermsConditions.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
    
}
