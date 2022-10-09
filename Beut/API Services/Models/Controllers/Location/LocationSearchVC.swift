//
//  LocationSearchVC.swift
//  Mahara - مهارة
//
//  Created by ProjectEgy on 29/08/2022.
//

import UIKit
import MapKit
import CoreLocation
class LocationSearchVC: UIViewController, UISearchResultsUpdating  {
  
    var locationManager:CLLocationManager!

    
 
    var fullAddress = ""
    @IBOutlet weak var locationInfo: UILabel!
    var previousLocation:CLLocation? = nil
    @IBOutlet weak var mapView: MKMapView!
    
    
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
        AddressVC.street = self.fullAddress
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultsVC = searchController.searchResultsController as? ResultViewController
        else{
            
            return
        }
        resultsVC.delegate = self
                    GooglePlacesManger.shared.findPlaces(query: query){
                        (results) in
        
                        switch results{
                        case .success(let data):
                            DispatchQueue.main.async {
                                resultsVC.update(with:data)
                            }
        
                        case .failure(let error):
                            print("Error:\(error.localizedDescription)")
                        }
                    }
    }
}


extension LocationSearchVC:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        locationInfo.text = "Loading".localized
        let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)

        getLocationInfo(location:newLocation)

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

