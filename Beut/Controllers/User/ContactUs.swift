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
        getContactInfo()
        
    }
    
    private func renderrContactInfo(){
        if let contact = contact {
            self.email.isHidden = false
            self.phoneNumber.isHidden = false
            self.address.isHidden = false
            if let email = contact.email{
                self.email.text = email
            }
            if let phone = contact.phone{
                self.phoneNumber.text = phone
            }
            if let address = contact.address{
                self.address.text = address
            }
        }
    }
   
    @IBAction func whatsapp(_ sender: Any) {
        guard let contact = contact else {
            return
        }

        guard let number = contact.twitter else {return}
        
        let whatssApp = "https://api.whatsapp.com/send?phone=00\(number)"
        print("Whatssapp:\(whatssApp)")
        self.openUrl(url: whatssApp)
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
        guard let email = contact.email else {return}
        self.openUrl(url: email)
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
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    func makeCall(phoneNumber: String) {
       let formattedNumber = phoneNumber.components(separatedBy:
       NSCharacterSet.decimalDigits.inverted).joined(separator: "")

       let phoneUrl = "tel://\(formattedNumber)"
       let url:NSURL = NSURL(string: phoneUrl)!
          UIApplication.shared.open(url as URL, options: [:], completionHandler:nil)
    }
    
    private func getContactInfo(){
        self.indicator.customIndicator(start: true, type: .ballBeat)
        NetworkService.shared.getContactInfo(parameters: nil) { [weak self] result in
            switch result {
            case .success(let info):
                print("Info:\(info)")
                self?.indicator.customIndicator(start: false)
                self?.contact =  info.data
                self?.renderrContactInfo()
                
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                print(error.localizedDescription)
            }
        }
    }
    
//
}
