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
   
//   override var navigationItem: UINavigationItem
    @IBOutlet var arrowImages: [UIImageView]!
    @IBOutlet weak var logInView: UIView!
    @IBOutlet weak var logOutIndicator: NVActivityIndicatorView!
    @IBOutlet weak var logOut: UIView!
    @IBOutlet weak var profileInfoHight: NSLayoutConstraint!
    @IBOutlet weak var complaints: UIView!
    @IBOutlet weak var changePassowrd: UIView!
    @IBOutlet weak var notificatios: UIView!
    @IBOutlet weak var wallet: UIView!
    @IBOutlet weak var profile: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
//    let navBarAppearance = UINavigationBarAppearance()
     
    override func viewDidLoad() {
        print(arrowImages.count)

        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(named: "EsfenjaColor")
        handleLogInAndLogOut()
        renderUserInfo()
        setUpLanguage()
    }
    
    private func setUpLanguage(){
        if let currentLanguage = LocalizationManager.shared.getLanguage(){
            if currentLanguage == .Arabic{
            for image in arrowImages{
                image.image = UIImage(named: "right")
//                image.image?.flipsForRightToLeftLayoutDirection
            }
        }
        }
    }
    @IBAction func changeLanguage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
        let mainHome = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
        var alretSheet = UIAlertController(title: "ChangeLanguage".localized, message: nil, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad{
            alretSheet = UIAlertController(title: "ChangeLanguage".localized, message: nil, preferredStyle: .alert)
        }
        alretSheet.addAction(UIAlertAction(title: "English".localized, style: .default, handler: {
            action in
            LocalizationManager.shared.setLanguage(language: .English)
            
            self.present(mainHome, animated:true, completion:nil)
        }))
        
        alretSheet.addAction(UIAlertAction(title: "Arabic".localized, style: .default, handler: {
            
            action in
           
            LocalizationManager.shared.setLanguage(language: .Arabic)
            
            self.present(mainHome, animated:true, completion:nil)
           
        }))
        alretSheet.addAction(UIAlertAction(title: "CANCEL".localized, style: .default, handler: nil))
        present(alretSheet, animated: true, completion: nil)
    }
    
    /// <#Description#>
    /// - Parameter sender: <#sender description#>
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.isUserLoggedInt = false
        handleLogInAndLogOut()
        UserDefaults.standard.set(nil, forKey: "userAccountInfo")
     
        let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
        let mainHome = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
        self.present(mainHome, animated:true, completion:nil)

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
            userName.removeFromSuperview()
            userPhone.removeFromSuperview()
//            points.removeFromSuperview()
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
    
    
    @IBAction func shareApp(_ sender: Any) {
        // text to share
               let text = "https://esfenja.page.link/WWy67ngwr1dEkwbA6"
               
               // set up activity view controller
               let textToShare = [ text ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
               
               // exclude some activity types from the list (optional)
               activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
               
               // present the view controller
               self.present(activityViewController, animated: true, completion: nil)
    }
    private func renderUserInfo(){
        
       
        if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key: "userAccountInfo"){
            if let image = result.image{
                let imageUrl = "\(Route.baseUrl)\(image)"
                self.profileImage.kf.setImage(with:imageUrl.asURL)
            }else{
                self.profileImage.image = UIImage(named: "avatar")!
            }
            userName.text = result.name!
            userPhone.text = result.phone!
//            if let points = result.point{
//                self.points.text = "\(points) " + "Points".localized
//            }else{
//                self.points.text = "0.0 " + "Points".localized
//            }
        }
    }
}
