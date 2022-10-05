//
//  LogInViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 21/06/2022.
//

import UIKit
import Foundation
import NVActivityIndicatorView
@available(iOS 13.0, *)
class LogInViewController: UIViewController, UITextFieldDelegate {
     
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var phoneNumber: CustomUITextField!
    @IBOutlet weak var password: CustomUITextField!
    @IBOutlet weak var btnLogIn: UIButton!
    
    private var validation:ValidationService
    
    init(validation:ValidationService){
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LogIn".localized
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == password{
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return false
    }

    @IBAction func login(_ sender: Any) {
        
        do{
            let phone = try validation.validatePhoneNumber(phoneNumber.text)
            let password = try validation.validatePassword(password.text)
            logIn(body: ["Phone":phone, "Password":password ])
            
        }catch{
            self.showInofToUser(title: "Error", message: error.localizedDescription)
        }
    }
    
    private func successfullLogin(){
        self.btnLogIn.isEnabled = false
        self.indicator.customIndicator(start: false)
        self.makeViewInVisible(wannaMakeItVisible: false)
        self.openMainHome()
    }

    
    @IBAction func skipLogin(_ sender: Any) {
        self.openMainHome()
    }
    
    private func openMainHome(){
        let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
        let mainHome = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
        self.present(mainHome, animated:true, completion:nil)
    }
    
    private func logIn(body:[String:Any]){
        self.indicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        let encoder = JSONEncoder()
        
        NetworkService.shared.logIn(parameters: body) {
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                if data.errorCode! == 0{
                    if let encoded = try? encoder.encode(data.data!) {
                        UserDefaults.standard.set(encoded, forKey: "userAccountInfo")
                    }
                    UserDefaults.standard.isUserLoggedInt = true
                    self?.successfullLogin()
                }else{
                    guard let errorMessage = data.errorMessage else {return}
                    if let error = EsfenjaCustomError(rawValue: errorMessage){
                        if error == .AccountNotVerified{
                            let storyboard = UIStoryboard(name: "VerifyNumber", bundle: nil)
                            let verifyAccount = storyboard.instantiateViewController(withIdentifier: "VerifyNumberID")
                            self?.navigationController?.pushViewController(verifyAccount, animated: true)
                        }else{
                            self?.showInofToUser(title: "Error", message: errorMessage)
                        }
                    }
                    self?.indicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
//                    self?.showInofToUser(title: "Error", message: data.errorMessage!)
                    
                }
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
