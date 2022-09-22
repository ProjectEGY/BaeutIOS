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
        LocalizationManager.shared.delegate = self
        LocalizationManager.shared.setAppInnitLanguage()
       
        
        return true
    }
}

@available(iOS 13.0, *)
extension AppDelegate: LocalizationDelegate {
   
    func resetApp() {
        guard let window = window else {
            return }
        var controller:UIViewController!
        
        
        if UserDefaults.standard.hasOnboarded {
            let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! UITabBarController
            
           
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController")
        }
        window.rootViewController = controller
        window.makeKeyAndVisible()
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }
}
