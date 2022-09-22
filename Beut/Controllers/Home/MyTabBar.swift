//
//  MyTabBarViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 28/06/2022.
//

import UIKit

@available(iOS 13.0, *)
class MyTabBarViewController: UITabBarController {
    var basket = BasketViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .white// your color
    }
}
