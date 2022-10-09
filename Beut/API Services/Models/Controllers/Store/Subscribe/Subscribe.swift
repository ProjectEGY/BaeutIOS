//
//  SubscribeViewController.swift
//  Esfenja
//
//  Created by ProjectEgy on 17/07/2022.
//

import UIKit
import MapKit
import CoreLocation
class SubscribeViewController: UIViewController, CLLocationManagerDelegate {

    var subInfo:StoreDetails?
    @IBOutlet weak var storeIsOpen: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeLocation: UIImageView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }



    @IBAction func openStoreLocation(_ sender: Any) {
        if let result = subInfo{
            let coordinates = CLLocationCoordinate2DMake(result.longitude!, result.latitude!)
            openMapsAppWithDirections(to: coordinates, destinationName: result.name!)
        }
        
    }
    @available(iOS 13.0, *)
    func setUpSubscribe(storeInfo:StoreDetails){
        subInfo = storeInfo
        if storeInfo.isOpen!{
            storeIsOpen.text = "open".localized
        }else{
            storeIsOpen.text = "close".localized
            storeIsOpen.textColor = .red
        }
        if let address = storeInfo.address{
            storeAddress.text = address
        }else{
            storeAddress.text = ""
        }
        
    }
    

    func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
      let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = name // Provide the name of the destination in the To: field
        mapItem.openInMaps(launchOptions: options)
    }
    
}
