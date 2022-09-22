//
//  ChangePasswordViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 05/07/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class ChangePasswordViewController: UIViewController {
//    let helper = Helper()
    @IBOutlet weak var oldPassword: CustomForIcons!
    @IBOutlet weak var newPassword: CustomForIcons!
    @IBOutlet weak var newPasswordConfirm: CustomForIcons!
    
    @IBOutlet weak var changePasswordIndicator: NVActivityIndicatorView!
    
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
        navigationController?.isNavigationBarHidden = false
        oldPassword.addLeftImage(image: UIImage(named: "lock_small_black")!)
        newPassword.addLeftImage(image: UIImage(named: "lock_small_black")!)
        newPasswordConfirm.addLeftImage(image: UIImage(named: "lock_small_black")!)
        
        title = "ChangePassword".localized
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func changePassword(_ sender: Any) {
        
        do{
            let oldPassword = try validation.validatePassword(oldPassword.text)
            let newPassword = try validation.validatePassword(newPassword.text)
            let confirmNewPassword = try validation.validateConfirmPassword(newPasswordConfirm.text)
            _ = try validation.compareTwoPasswords(newPassword, confirmNewPassword)
            
            let params = ["OldPassword":oldPassword, "NewPassword":newPassword]
                changePAssword(body: params)
            
        }catch{
            self.showInofToUser(title: "Error", message: error.localizedDescription)
        }
    }
    private func successOrFailedToChangePassword(){
        self.makeViewInVisible(wannaMakeItVisible: false)
        self.changePasswordIndicator.customIndicator(start: false)
    }
    private func changePAssword(body:[String:Any]){
        self.makeViewInVisible(wannaMakeItVisible: true)
        self.changePasswordIndicator.customIndicator(start: true, type: .ballTrianglePath)
        NetworkService.shared.changePassword(parameters: body){
        [weak self] (result) in

        switch result{
        case .success(let data):
            self?.successOrFailedToChangePassword()
            if data .errorCode == 0{
                self?.showInofToUser(message: "PasswordChangedSuccessfully".localized)
                
            }
            else{
                self?.successOrFailedToChangePassword()
                self?.showInofToUser(title: "Error", message: data.errorMessage!)
            }
            
        case .failure(let error):
            self?.successOrFailedToChangePassword()
            self?.showInofToUser(title: "Error", message: error.localizedDescription)
            }
        }
 
    }
}
