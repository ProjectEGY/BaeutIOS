//
//  MyAccount.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/06/2022.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
@available(iOS 13.0, *)
class MyAccount: UIViewController{
   
    @IBOutlet var arrowImages: [UIImageView]!
    @IBOutlet weak var logInView: UIView!
    @IBOutlet var logOutIndicator: NVActivityIndicatorView!
    @IBOutlet weak var logOut: UIView!
    @IBOutlet weak var profileInfoHight: NSLayoutConstraint!
    @IBOutlet weak var complaints: UIView!
    @IBOutlet weak var changePassowrd: UIView!
    @IBOutlet weak var notificatios: UIView!
    @IBOutlet weak var wallet: UIView!
    @IBOutlet weak var profile: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    let appUrl = "https://apps.apple.com/us/app/Beuat/6443587383"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLogInAndLogOut()
        renderUserInfo()
        setUpLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.renderUserInfo()
    }
    
    private func setUpLanguage(){
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            for image in arrowImages{
                image.image = UIImage(named: "right")
            }
        }
    }
    
    @IBAction func changeLanguage(_ sender: Any) {
        self.changeAppLanguage()
    }
 
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.isUserLoggedInt = false
        handleLogInAndLogOut()
        UserDefaults.standard.set(nil, forKey: "userAccountInfo")
        self.goToHomePage()
    }
    
    @IBAction func rateApp(_ sender: Any) {
        guard let appURL = NSURL(string:self.appUrl) else{return}
        if UIApplication.shared.canOpenURL(appURL as URL) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    private func logUserOut(){
        UserDefaults.standard.isUserLoggedInt = false
        UserDefaults.standard.didUserSelectCity = false
        handleLogInAndLogOut()
        UserDefaults.standard.set(nil, forKey: "userAccountInfo")
        self.presentViewController(storyboardName: "SignIn", with: "SignIn")
    }
    
    func getTodayString() -> String{

                    let date = Date()
                    let calender = Calendar.current
                    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

                    let year = components.year
                    let month = components.month
                    let hour = components.hour
                    let minute = components.minute
                    let second = components.second

                    let today_string = String(year!) + String(month!) + String(hour!) + String(minute!) +  String(second!)

                    return today_string

                }
    
    private func deleteUserAccount(body:[String:Any]){
        logOutIndicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        NetworkService.shared.updateProfile(parameters: body){
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                self?.logOutIndicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                if data.errorCode! == 0{
                    self?.logUserOut()
                    self?.showInofToUser(message: "DeletedSuccessfully".localized)
                }else{
                    self?.showInofToUser(title: "Error", message: "\(data.errorMessage ?? "")")
                }
            case .failure(let error):
                self?.logOutIndicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    private func changeAppLanguage(){
        var alretSheet = UIAlertController(title: "ChangeLanguage".localized, message: nil, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad{
            alretSheet = UIAlertController(title: "ChangeLanguage".localized, message: nil, preferredStyle: .alert)
        }
        alretSheet.addAction(UIAlertAction(title: "English".localized, style: .default, handler: {
            action in
            UserDefaults.standard.setValue("English", forKey: "Lang")
            MOLH.setLanguageTo("en")
            MOLH.reset()
            self.goToHomePage()
        }))
        
        alretSheet.addAction(UIAlertAction(title: "Arabic".localized, style: .default, handler: {
            
            action in
            UserDefaults.standard.setValue("Arabic", forKey: "Lang")
            MOLH.setLanguageTo("ar")
            MOLH.reset()
            self.goToHomePage()
           
        }))
        alretSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .default, handler: nil))
        present(alretSheet, animated: true, completion: nil)
    }
    
    private func goToHomePage(){
        self.presentViewController(storyboardName: "TabBarNavigator", with: "MainTabID")
    }
    
    private func handleLogInAndLogOut(){
        if !UserDefaults.standard.isUserLoggedInt{
            profile.isHidden = true
            changePassowrd.isHidden = true
            notificatios.isHidden = true
            wallet.isHidden = true
            complaints.isHidden = true
            logOut.isHidden = true
            logInView.isHidden = false
            deleteView.isHidden = true
            userName.removeFromSuperview()
            userPhone.removeFromSuperview()
//            points.removeFromSuperview()
        }else{
            deleteView.isHidden = false
        }
    }
//    @IBAction func logIn(_ sender: Any) {
//                UserDefaults.standard.isUserLoggedInt = false
//
//                let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
//
//                let loginView = storyBoard.instantiateViewController(withIdentifier: "SignIn") as! LogInNavBarViewController
//
//                self.present(loginView, animated:true, completion:nil)
//    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        let newNumber = "0100" + getTodayString()
        
        let body = ["Name":"Name_" + newNumber, "Phone":newNumber, "Password":"", "Image":""]
        let alretSheet = UIAlertController(title: "DeleteAccount".localized, message: "wannaDelete".localized, preferredStyle: .alert)

        alretSheet.addAction(UIAlertAction(title: "Delete".localized, style: .destructive, handler: {
            action in
            self.deleteUserAccount(body:body)
            
        }))
     
        alretSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: nil))
        present(alretSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func shareApp(_ sender: Any) {
        
        let textToShare = [ "Bueat - بيوت", self.appUrl ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
               
               // exclude some activity types from the list (optional)
               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
               
               // present the view controller
               self.present(activityViewController, animated: true, completion: nil)
    }
    private func renderUserInfo(){
        guard let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key: "userAccountInfo") else {return}
            if let image = result.image{
                let imageUrl = "\(Route.baseUrl)\(image)"
                self.profileImage.kf.setImage(with:imageUrl.asURL)
            }else{
                self.profileImage.image = UIImage(named: "avatar")!
            }
            if let name = result.name{
                userName.text = name
            }
            if let phone = result.phone{
                userPhone.text = phone
            }
    }
}
