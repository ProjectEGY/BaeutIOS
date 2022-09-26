//
//  SignUpViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 22/06/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class SignUpViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    private var didSelectImage = false
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var signUpIndeicator: NVActivityIndicatorView!
    @IBOutlet weak var userImage: UIImageView!
    var imageStr = ""
    @IBOutlet weak var name: Custom!
    @IBOutlet weak var phoneNumber: Custom!
    @IBOutlet weak var password: Custom!
    @IBOutlet weak var confirmPassword: Custom!
    
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
        password.textContentType = .oneTimeCode
        confirmPassword.textContentType = .oneTimeCode
        title = "CreateAccount".localized
        super.viewDidLoad()
        self.imagePicker.allowsEditing = true
//        userImage.makeImageCircular(anyImage:userImage.image!)
        self.name.handleArabicLanguage()
        self.phoneNumber.handleArabicLanguage()
        self.password.handleArabicLanguage()
        self.confirmPassword.handleArabicLanguage()
    }
    
    @IBAction func signUp(_ sender: Any) {
        
            do{
                
            let username = try validation.validateUsername(name.text)
            let phone = try validation.validatePhoneNumber(phoneNumber.text)
            let password = try validation.validatePassword(password.text)
            let confirmPass = try validation.validateConfirmPassword(confirmPassword.text)
            _ = try validation.compareTwoPasswords(password, confirmPass)
            let body = ["Name":username, "Phone":phone, "Password":password, "Image":imageStr]
            signUpAPI(body: body)
                
            }catch{
                self.showInofToUser(title: "Error", message: error.localizedDescription)
            }
    }
  
    private func setUpRegestration(){
        btnSignUp.isEnabled = false
        signUpIndeicator.isHidden = false
        signUpIndeicator.startAnimating()
        btnSignUp.isEnabled = true
        let myView = storyboard?.instantiateViewController(identifier: "VerifyNumberID") as! VerfiyNumberViewController
        present(myView, animated: true, completion: nil)
    }
    
    @IBAction func selectUserPhoto(_ sender: Any) {
        self.choseImage()
    }
    
    public func signUpAPI(body:[String:Any]){
        self.signUpIndeicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        NetworkService.shared.signUp(parameters: body){
            [weak self] (resut) in
            
            switch resut{
            case .success(let data):
                if let code = data.errorCode{
                    if code == 0{
                    self?.signUpIndeicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showVerifyNumberView(user:data.data!, password:body["Password"] as! String)
                    }
                    else{
                        self?.signUpIndeicator.customIndicator(start: false)
                        self?.makeViewInVisible(wannaMakeItVisible: false)
                        self?.showInofToUser(title: "Error", message:data.errorMessage!)
                    }
                }
            case .failure(let error):
                self?.signUpIndeicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

@available(iOS 13.0, *)
extension SignUpViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    
    private func choseImage(){
        
        let alretSheet = UIAlertController(title: "SelectPhoto".localized, message: nil, preferredStyle: .actionSheet)
        alretSheet.addAction(UIAlertAction(title: "Takephoto".localized, style: .default, handler: {
            action in
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        
        }))
        
        alretSheet.addAction(UIAlertAction(title: "SelectfromAlbum".localized, style: .default, handler: {
            
            action in
            self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        if didSelectImage {
            alretSheet.addAction(UIAlertAction(title: "Removephoto".localized, style: .default, handler: { [self]
                action in
                self.userImage.image = UIImage(systemName: "camera")
                self.didSelectImage = false
                
                let imageData:NSData = self.userImage.image!.pngData()! as NSData
                imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))

            }))
        }
        
        
        alretSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .default, handler: nil))
        present(alretSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                {
            userImage.image = img

                }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
                {
            userImage.image = img
                }

        userImage.makeImageCircular(anyImage: userImage.image!)
        didSelectImage = true
    }
}

@available(iOS 13.0, *)
extension SignUpViewController{
    
    private func showVerifyNumberView(user:User, password:String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "VerifyNumber", bundle:nil)
        
        let verifyNumber = storyBoard.instantiateViewController(withIdentifier: "VerifyNumberID") as! VerfiyNumberViewController
        verifyNumber.userInfo = user
        verifyNumber.userPassword = password
        self.present(verifyNumber, animated:true, completion:nil)
    }
}
