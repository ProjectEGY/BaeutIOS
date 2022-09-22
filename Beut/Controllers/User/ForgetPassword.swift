//
//  ForgetPassword.swift
//  Esfenja
//
//  Created by ProjectEgy on 17/08/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class ForgetPassword: UIViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var forgetPasswordIndicator: NVActivityIndicatorView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var phone: Custom!
   
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
        btn.setTitle("resetPassword".localized, for: .normal)
        phone.placeholder = "phonePlaceholder".localized
        phone.handleArabicLanguage()
        lbl.text = "forgetPasswordLabel".localized
    }
    

    
    @available(iOS 13.0, *)
    @IBAction func resetPassword(_ sender: Any) {
        do {
            let phone = try validation.validatePhoneNumber(phone.text)
            
            self.forgetPasswordIndicator.customIndicator(start: true, type: .ballTrianglePath)
            self.makeViewInVisible(wannaMakeItVisible: true)
            NetworkService.shared.forgetPassword(parameters: ["Phone":phone]){
                [weak self] (result) in
                switch result{
                case .success(let data):
                    if let err = data.errorCode, err == 0{
                        self?.forgetPasswordIndicator.customIndicator(start: false)
                        self?.makeViewInVisible(wannaMakeItVisible: false)
                        self?.showInofToUser(message: "passwordResetSuccessfully")
                    }else{
                        self?.forgetPasswordIndicator.customIndicator(start: false)
                        self?.makeViewInVisible(wannaMakeItVisible: false)
                        self?.showInofToUser(title: "Error", message:data.errorMessage!)
                    }
                    
                case .failure(let error):
                    self?.forgetPasswordIndicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showInofToUser(title: "Error", message: error.localizedDescription)
                }
            }
        }catch{
            self.showInofToUser(title: "Error", message: error.localizedDescription)
        }
        
    }
    
}
