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
     
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var password: Custom!
    @IBOutlet weak var phoneNumber: Custom!
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
        phoneNumber.handleArabicLanguage()
        password.handleArabicLanguage()
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
                    print(data)
                    if let encoded = try? encoder.encode(data.data!) {
                        UserDefaults.standard.set(encoded, forKey: "userAccountInfo")
                    }
                    UserDefaults.standard.isUserLoggedInt = true
                    self?.successfullLogin()
                }else{
                   
                    self?.indicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showInofToUser(title: "Error", message: data.errorMessage!)
                    
                }
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
