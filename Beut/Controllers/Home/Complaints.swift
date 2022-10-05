//
//  ComplaintsViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/06/2022.
//

import UIKit
import NVActivityIndicatorView
@available(iOS 13.0, *)
class ComplaintsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var complaintMessage: CustomForComplaints!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Complaints".localized
        self.complaintMessage.handleArabicLanguage()
        // Do any additional setup after loading the view.
    }
    @IBAction func sendComplaint(_ sender: Any) {
        if complaintMessage.text == "" {
            AlertView.showAlertBox(title: "Error".localized, message: "ComplaintsErrorMessage".localized) { action in
               
            }.present(on: self) {}
        }else{
            if let message = complaintMessage.text{
                sendComplaints(message:message)
            }
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return false
    }
    
    private func sendComplaints(message:String){
        indicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        let body = ["Message":message]
        NetworkService.shared.sendComplaints(parameters: body){
            [weak self] (result) in
            switch result{
            case .success(let data):
                self?.indicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                
                if data.errorCode == 0{
                    AlertView.showAlertBox(title: "Information", message: "ComplaintsThanks".localized) { action in
                        let storyboard = UIStoryboard(name: "TabBarNavigator", bundle: nil)
                        let home = storyboard.instantiateViewController(withIdentifier: "MainTabID") as! MyTabBarViewController
                        self?.present(home, animated: true)
                    }.present(on: self!) {}
                }else{
                    AlertView.showAlertBox(title: "Error".localized, message: "Something went wrong") { action in
                                // Okay action code
                    }.present(on: self!) {}
                }
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title: "Error".localized, message: error.localizedDescription)
            }
        }
    }
    
}
