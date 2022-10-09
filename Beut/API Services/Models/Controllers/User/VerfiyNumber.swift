//
//  SignUpViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 22/06/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class VerfiyNumberViewController : UIViewController, UITextFieldDelegate{

    @IBOutlet weak var verifyIndicator: NVActivityIndicatorView!
    @IBOutlet weak var continueBtn: UIButton!
    var userInfo:User?
    var userPassword:String?
    @IBOutlet weak var digit1: UITextField!
    @IBOutlet weak var digit2: UITextField!
    @IBOutlet weak var digit3: UITextField!
    @IBOutlet weak var digit4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VerifyNumber".localized
        digit1.becomeFirstResponder()
        continueBtn.isEnabled = false
    }

    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text,
                              newText: string,
                              limit: 1)
    }
    
    
    @IBAction func verfiyAccount(_ sender: Any) {
        self.verifyIndicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        var verficationCode:String = digit1.text!
        verficationCode.append(digit2.text!)
        verficationCode.append(digit3.text!)
        verficationCode.append(digit4.text!)
        let encoder = JSONEncoder()
        if let user = userInfo, let pass = userPassword{
            let body = ["Phone":user.phone!, "Password":pass, "VerificationCode":verficationCode]
            NetworkService.shared.verfiyAccount(parameters: body){
                [weak self] (result) in

                switch result{
                case .success(let data):
                   
                    self?.verifyIndicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    guard let errorCode = data.errorCode, errorCode == 0 else {return}
                    guard let user = data.data else {return}
                    if let encoded = try? encoder.encode(user) {
                        UserDefaults.standard.set(encoded, forKey: "userAccountInfo")
                    }
                    UserDefaults.standard.isUserLoggedInt = true
                    self?.showAlert()
                case .failure(let error):
                    self?.verifyIndicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showInofToUser(title:"Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func moveToDigit2(_ sender: Any) {
        digit2.becomeFirstResponder()
    }
    
    
  
    @IBAction func moveToDigit3(_ sender: Any) {
        digit3.becomeFirstResponder()
    }
    
    
    @IBAction func moveToDigit4(_ sender: Any) {
        digit4.becomeFirstResponder()
    }
    
    @IBAction func activeButton(_ sender: Any) {
        continueBtn.isEnabled = true
    }
}

@available(iOS 13.0, *)
extension VerfiyNumberViewController{
    func showAlert(){
        
        
        let myAlret = UIAlertController(title: "Information", message: "AccountActivatedSuccessfully".localized, preferredStyle: .alert)
        myAlret.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            
            self.showMainHome()
            
        }))
        present(myAlret, animated: true, completion: nil)
        
    }
    private func showMainHome(){
       
        let storyBoard : UIStoryboard = UIStoryboard(name: "TabBarNavigator", bundle:nil)
        
        let mainHome = storyBoard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
        
        self.present(mainHome, animated:true, completion:nil)
        
        
    }
}
