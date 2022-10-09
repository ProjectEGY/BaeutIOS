//
//  AppDelegate.swift
//  Esfenja
//
//  Created by ProjectEgy on 22/06/2022.
//

import UIKit
import CoreLocation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var locationManager:CLLocationManager!
    var window: UIWindow?
    override init() {
        super.init()
        UIFont.overrideInitialize()
        if let result = LocationManger.shared.getCurrentLocationForUser(){
            UserDefaults.standard.saveCurrentUsetLocation(data: result, key: "currentUserLocation")
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
      SetupLanguage()
        return true
    }
}

extension AppDelegate: MOLHResetable{
    func SetupLanguage(){
        if Locale.current.languageCode == "ar"{
            MOLHLanguage.setDefaultLanguage("ar")
        }else if Locale.current.languageCode == "en"{
            MOLHLanguage.setDefaultLanguage("en")
        }
        MOLH.shared.activate(true)
        MOLH.shared.specialKeyWords = ["Cancel","Done"]
    }
    
    func reset() {
            var controller:UIViewController!
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                
        if UserDefaults.standard.hasOnboarded {
            let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! UITabBarController
            
           
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController")
        }
        rootviewcontroller.rootViewController = controller
    }
}
