//
//  ContactUsViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import UIKit

@available(iOS 13.0, *)
class ContactUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ContactUs".localized
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func whatsapp(_ sender: Any) {
    }
    
    
    @IBAction func twitter(_ sender: Any) {
    }
    
    @IBAction func instgram(_ sender: Any) {
    }
    
    @IBAction func facebook(_ sender: Any) {
        guard let url = URL(string: "https://facebook.com") else { return }
        UIApplication.shared.open(url)
    }
}
