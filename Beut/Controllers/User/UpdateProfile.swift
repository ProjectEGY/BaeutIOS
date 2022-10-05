//
//  AccountSettings.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/06/2022.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AccountSettings: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var updateIndicator: NVActivityIndicatorView!
    private var didSelectImage = false
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtPhone: CustomForIcons!
    @IBOutlet weak var txtUsername: CustomForIcons!
    
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
        txtUsername.addLeftImage(image: UIImage(named: "profile_small")!)
        txtPhone.addLeftImage(image: UIImage(named: "phone_small")!)
        title = "Profile".localized

        
        
        if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo"){
            if let image = result.image{
                let imageUrl = "\(Route.baseUrl)\(image)"
                self.profileImage.kf.setImage(with:imageUrl.asURL)
            }
            txtUsername.text = result.name!
            txtPhone.text = result.phone!
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func editProfileInfo(_ sender: Any) {
        do{
            let name = try validation.validateUsername(txtUsername.text)
            let phone = try validation.validatePhoneNumber(txtPhone.text)
            
            var body = ["Name":name, "Phone":phone, "Image":""]
            if didSelectImage{
                let imageData:NSData = profileImage.image!.pngData()! as NSData
                let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                body["Image"] = imageStr
            }
            updateProfileInfo(body:body)
            
        }catch{
            self.showInofToUser(title: "Error", message: error.localizedDescription)
        }
      
    }
    
    @IBAction func selectImage(_ sender: Any) {
        choseImage()
    }
    
    private func updateProfileInfo(body:[String:Any]){
        updateIndicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        NetworkService.shared.updateProfile(parameters: body){
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                self?.updateIndicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                guard let errorCode = data.errorCode, errorCode == 0 else {
                    self?.showInofToUser(title: "Error", message: "\(data.errorMessage ?? "")")
                    return
                }
                guard let user = data.data else {return}
                self?.updateUserDefaultsInfo(user:user)
                self?.showInofToUser(message: "Profileupdatedsuccessfully".localized)
                
            case .failure(let error):
                self?.updateIndicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
            }
        }
    }
    private func updateUserDefaultsInfo(user:User){
        var user = user
        let encoder = JSONEncoder()
        if user.token != nil{
            if let encoded = try? encoder.encode(user) {
                UserDefaults.standard.set(encoded, forKey: "userAccountInfo")
            }
        }else{
            if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo"){
                guard let oldToken = result.token else {return}
                user.token = oldToken
                if let encoded = try? encoder.encode(user) {
                    UserDefaults.standard.set(encoded, forKey: "userAccountInfo")
                }
                
            }
            
        }
    }
}


@available(iOS 13.0, *)
extension AccountSettings:UIImagePickerControllerDelegate & UINavigationControllerDelegate{

    private func choseImage(){
        
        var alretSheet = UIAlertController(title: "SelectPhoto".localized, message: nil, preferredStyle: .actionSheet)
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            alretSheet = UIAlertController(title: "ChangeLanguage".localized, message: nil, preferredStyle: .alert)
        }
        
//        alretSheet.addAction(UIAlertAction(title: "Takephoto".localized, style: .default, handler: {
//            action in
//            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
//            self.imagePicker.delegate = self
//            self.present(self.imagePicker, animated: true, completion: nil)
//
//        }))
        
        alretSheet.addAction(UIAlertAction(title: "SelectfromAlbum".localized, style: .default, handler: {
            
            action in
            self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        if didSelectImage {
            alretSheet.addAction(UIAlertAction(title: "Removephoto".localized, style: .default, handler: {
                action in
//                self.profileImage.image = UIImage(systemName: "camera")
                self.didSelectImage = false
            }))
        }
        
        
        alretSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .default, handler: nil))
        present(alretSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImage.image = img
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
                {
            profileImage.image = img
                }
        didSelectImage = true
    }
}
