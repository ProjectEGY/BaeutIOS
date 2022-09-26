//
//  ContactUsViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var indicator:NVActivityIndicatorView!
    @IBOutlet weak var address:UILabel!
    @IBOutlet weak var phoneNumber:UILabel!
    @IBOutlet weak var email:UILabel!
    var contact :AboutInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ContactUs".localized
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func whatsapp(_ sender: Any) {
        guard let contact = contact else {
            return
        }

        guard let whatsappLink = contact.twitter else {return}
        self.openUrl(url: whatsappLink)
    }
    
    @IBAction func call(_ sender: Any) {
        guard let contact = contact else {
            return
        }
        guard let phone = contact.phone else {return}
        self.makeCall(phoneNumber: phone)
    }
    
    @IBAction func openEmail(_ sender: Any) {
        guard let contact = contact else {
            return
        }
        guard let phone = contact.phone else {return}
        self.makeCall(phoneNumber: phone)
    }
    
    @IBAction func twitter(_ sender: Any) {
        guard let contact = contact else {
            return
        }

        guard let instaLink = contact.twitter else {return}
        self.openUrl(url: instaLink)
    }
    
    @IBAction func instgram(_ sender: Any) {
        guard let contact = contact else {
            return
        }

        guard let instaLink = contact.instagram else {return}
        self.openUrl(url: instaLink)
    }
    
    @IBAction func facebook(_ sender: Any) {
        guard let contact = contact else {
            return
        }
        
        guard let facebookUrl = contact.facebook else {return}
        self.openUrl(url: facebookUrl)
    }
    
    private func openUrl(url:String){
        guard let url = URL(string: "https://facebook.com") else { return }
        UIApplication.shared.open(url)
    }
    
    func makeCall(phoneNumber: String) {
       let formattedNumber = phoneNumber.components(separatedBy:
       NSCharacterSet.decimalDigits.inverted).joined(separator: "")

       let phoneUrl = "tel://\(formattedNumber)"
       let url:NSURL = NSURL(string: phoneUrl)!

       if #available(iOS 10, *) {
          UIApplication.shared.open(url as URL, options: [:], completionHandler:
          nil)
       } else {
         UIApplication.shared.openURL(url as URL)
       }
    }
    
    private func getContactInfo(){
        self.indicator.customIndicator(start: true)
        NetworkService.shared.getContactInfo(parameters: nil) { [weak self] result in
            switch result {
            case .success(let info):
                self?.indicator.customIndicator(start: false)
                self?.contact =  info.data
                
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                print(error.localizedDescription)
            }
        }
    }
}
