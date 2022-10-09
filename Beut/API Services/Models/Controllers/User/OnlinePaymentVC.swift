//
//  OnlinePaymentVC.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/08/2022.
//

import UIKit
import WebKit

class OnlinePaymentVC: UIViewController {

    @IBOutlet weak var paymentWebView: WKWebView!
    
    var paymentURL:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            title = "OnlinePayment".localized
        } else {
            // Fallback on earlier versions
            title = "Online Payment"
        }
        guard let paymentUrl = self.paymentURL else {return}
        guard let url = URL(string: paymentUrl) else{
            return
        }
        paymentWebView.load(URLRequest(url: url))
        
    }
    

}
