//
//  LocationSearchVC.swift
//  Esfenja
//
//  Created by ProjectEgy on 01/09/2022.
//

import UIKit
import MapKit
import CoreLocation
class LocationSearchVC: UIViewController, UISearchResultsUpdating  {
  
    var locationManager:CLLocationManager!

    
 
    var fullAddress = ""
    var previousLocation:CLLocation? = nil
    var locationSelectedByUser:CLLocation?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationInfo:UILabel!
    
    let searchVC = UISearchController(searchResultsController: ResultViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.backgroundColor = .white
        
        navigationItem.searchController = searchVC
        
    }
    
    @IBAction func userDidSelectAddress(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            AddressViewController.didUserSelectLocationUsingMap = true
            AddressViewController.street = self.fullAddress
            AddressViewController.locationSelectedByUser = self.locationSelectedByUser
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultsVC = searchController.searchResultsController as? ResultViewController
        else{
            
            return
        }
        resultsVC.delegate = self
        self.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultsVC.update(with:places)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
        public func findPlaces(query:String, completion:@escaping(Result<[Place], Error>)->Void){
            let geoCoder = CLGeocoder()
            
            geoCoder.geocodeAddressString(query) { results, error in
                guard let results = results, error == nil else{
                    completion(.failure(error!))
                    return
                }
                guard let newResult = results.first else {return}
                
                guard let location = newResult.location else {return}
                var fullName = ""
                if let name = newResult.country{
                    fullName += name
                }
                if let city = newResult.locality{
                    fullName += ", " + city
                }
                if let street = newResult.locality{
                    fullName += ", " + street
                }
                let newPlaces:[Place] = results.compactMap({_ in
                 
                    Place(name: fullName, id: fullName, location: location)
                    
                })
                completion(.success(newPlaces))
                
            }

        }
}





extension LocationSearchVC:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if #available(iOS 13.0, *) {
            locationInfo.text = "Loading...".localized
        } else {
            locationInfo.text = "Loading..."
        }
        let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)

        getLocationInfo(location:newLocation)

    }
    
    private func getLocationInfo(location:CLLocation){
        self.locationSelectedByUser = location
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

            self.locationInfo.text = self.fullAddress
            
        }
    }
}

extension LocationSearchVC:ResultViewControllerDelegate{
    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
        
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true, completion: nil)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        mapView.setRegion(MKCoordinateRegion(center: coordinates, span:span), animated: true)
    }
    
    
}

