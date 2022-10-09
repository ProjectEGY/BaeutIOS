//
//  SceneDelegate.swift
//  Esfenja
//
//  Created by ProjectEgy on 22/06/2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // Use a UIHostingController as window root view controller
      
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        var controller:UIViewController!
        if UserDefaults.standard.hasOnboarded {  
            let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! UITabBarController
            
           
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController")
        }
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        
    }

 
}

