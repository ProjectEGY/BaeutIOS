//
//  AddressViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 20/07/2022.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView
@available(iOS 13.0, *)
class AddressViewController: UIViewController {
    
    static var street:String?

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var addressInDetails: UITextField!
    @IBOutlet weak var mapsAddress: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet weak var building: UITextField!
    @IBOutlet weak var appartment: UITextField!
    @IBOutlet weak var floor: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Address".localized
       
        navigationItem.backButtonTitle = ""
        showCurrentInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let street = AddressViewController.street{
            mapsAddress.text = street
        }
    }
    

    private func showCurrentInfo(){
        if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo"){
            userName.text = result.name!
            userPhone.text = result.phone!
        }
    }
    
    @IBAction func saveAddress(_ sender: Any) {
        addNewAddress()
    }
    
    private func addNewAddress(){
        
        indicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        indicator.customIndicator(start: true, type: .ballTrianglePath)
        okButton.isEnabled = false
        
        
        var params = [
            "Id":0,
            "Name":"",
            "Latitude": 0.0,
            "Longitude": 0.0,
            "Address":"",
            "Floor":"",
            "BuildingNumber":"",
            "Apartment":"",
            "PhoneNumber":"",
            "AddressInDetails":""] as JSON
        
        if let currentLocation = LocationManger.shared.getCurrentLocationForUser(){
            if let lat = currentLocation.latitude,
               let long = currentLocation.longitude{
                params["Latitude"] = lat
                params["Longitude"] = long
            }
        }
        
        if let name = userName.text,
           let addressDetails = addressInDetails.text,
           let floor = floor.text,
           let building = building.text,
           let apartment = appartment.text,
           let phone = userPhone.text,
           let address = AddressViewController.street{
            params["Name"] = name
            params["Floor"] = floor
            params["BuildingNumber"] = building
            params["Apartment"] = apartment
            params["PhoneNumber"] = phone
            params["AddressInDetails"] = addressDetails
            params["Address"] = address
        }
        NetworkService.shared.addNewAddress(parameters: params){
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                if data.errorCode == 0{
                    self?.indicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showInofToUser(message: "Addressisadded".localized)
                    self?.navigationController?.popViewController(animated: true)
                }
                else{
                    self?.indicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
                    self?.showInofToUser(title:"Error",message: "\(data.errorMessage ?? "Failed")")
                }
            case .failure(let error):
                self?.indicator.customIndicator(start: false)
                self?.makeViewInVisible(wannaMakeItVisible: false)
                self?.showInofToUser(title:"Error",message: error.localizedDescription)
            }
        }
        
  
    }

}
