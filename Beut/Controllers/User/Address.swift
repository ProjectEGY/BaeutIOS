//
//  AddressViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 20/07/2022.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView
import CoreLocation
@available(iOS 13.0, *)
class AddressViewController: UIViewController, UITextFieldDelegate {
    
    static var street:String?
    var fullAddress = ""
    static var didUserSelectLocationUsingMap = false
    static var locationSelectedByUser:CLLocation?
    var currentCoordinates:CurrentLocation?
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        AddressViewController.didUserSelectLocationUsingMap = false
        title = "Address".localized
        navigationItem.backButtonTitle = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let street = AddressViewController.street{
            mapsAddress.text = street
        }
        showCurrentInfo()
        if !AddressViewController.didUserSelectLocationUsingMap{
            self.getCurrentAddress()
        }
        
    }
    
    private func getCurrentAddress(){
        if let location = LocationManger.shared.getCurrentLocationForUser(){
            guard let lat = location.latitude, let long = location.longitude else {return}
            self.getLocationInfo(location: CLLocation(latitude: lat, longitude: long))
            if !AddressViewController.didUserSelectLocationUsingMap{
                print("A:\(location)")
                self.currentCoordinates = location
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == addressInDetails{
            scrollView.setContentOffset(CGPoint(x: 0, y: 160), animated: true)
        }else if textField == building ||  textField == appartment ||  textField == floor{
            scrollView.setContentOffset(CGPoint(x: 0, y: 180), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        return false
    }
    
    private func showCurrentInfo(){
        if let result = UserDefaults.standard.readUserInfoFromoUserDefaults(key:"userAccountInfo"){
            if let name = result.name{
                userName.text = name
            }
            if let phone = result.phone{
                userPhone.text = phone
            }
            
        }
    }
    
    @IBAction func saveAddress(_ sender: Any) {
        addNewAddress()
    }
    
    private func saveAddressToOrder(){
        let params = ["IsStoreOrder":true] as [String:Any]
        NetworkService.shared.saveAddressToOrder(parameters: params){
            (result) in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getLocationInfo(location:CLLocation){
        
        fullAddress = ""
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, error in
            
            guard let places = places, error == nil else {return}

            var placeMark: CLPlacemark!
            placeMark = places[0]
            // Place details
   
            if let x = placeMark.subAdministrativeArea{
                self.fullAddress += x + ", "
            }
            if let street = placeMark.thoroughfare {
                self.fullAddress += street + ", "
            }
            
            // City
            if let city = placeMark.locality {
                self.fullAddress += city + ", "
            }
            // Country
            if let country = placeMark.country {
                self.fullAddress += country
            }

            self.mapsAddress.text = self.fullAddress
            if !AddressViewController.didUserSelectLocationUsingMap{
                AddressViewController.street = self.fullAddress
                print("B:\(location)")
            }
        }
    }
    
    private func addNewAddress(){
        indicator.customIndicator(start: true, type: .ballTrianglePath)
        self.makeViewInVisible(wannaMakeItVisible: true)
        indicator.customIndicator(start: true, type: .ballTrianglePath)
        
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
        if AddressViewController.didUserSelectLocationUsingMap{
            guard let location = AddressViewController.locationSelectedByUser else {return}
            params["Latitude"] = location.coordinate.latitude
            params["Longitude"] = location.coordinate.longitude
            print("C:\(location)")
        }else{
            guard let currentCoordinates = currentCoordinates else {return}
            print("D:\(currentCoordinates)")
            if let lat = currentCoordinates.latitude{
                params["Latitude"] = lat
            }
            if let long = currentCoordinates.longitude{
                params["Longitude"] = long
            }
        }
        
        
        
        if let name = userName.text, !name.isEmpty{
            params["Name"] = name
        }
        if let addressDetails = addressInDetails.text, !addressDetails.isEmpty{
            params["AddressInDetails"] = addressDetails
        }
        if let floor = floor.text, !floor.isEmpty{
            params["Floor"] = floor
        }
        if let building = building.text, !building.isEmpty{
            params["BuildingNumber"] = building
        }
        if let apartment = appartment.text, !apartment.isEmpty{
            params["Apartment"] = apartment
        }
        if let phone = userPhone.text, !phone.isEmpty{
            params["PhoneNumber"] = phone
        }
        if let address = AddressViewController.street, !address.isEmpty{
            params["Address"] = address
        }
        print("AddressBody:\(params)")
        NetworkService.shared.addNewAddress(parameters: params){
            
            [weak self] (result) in
            
            switch result{
            case .success(let data):
                if data.errorCode == 0{
                    self?.saveAddressToOrder()
                    self?.indicator.customIndicator(start: false)
                    self?.makeViewInVisible(wannaMakeItVisible: false)
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
