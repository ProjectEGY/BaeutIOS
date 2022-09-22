//
//  LocationManger.swift
//  Esfenja
//
//  Created by ProjectEgy on 21/08/2022.
//

import Foundation
import CoreLocation

typealias JSON = [String:Any]
class LocationManger{
    var locationManager:CLLocationManager!
    
    private init(){
        
    }
    
    static var shared = LocationManger()
    
    public func getCurrentLocationForUser()->CurrentLocation?{
        
        locationManager = CLLocationManager()
        self.locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        let currentUserLocation = CurrentLocation(longitude: locationManager.location?.coordinate.longitude, latitude: locationManager.location?.coordinate.latitude)
        return currentUserLocation
        }
}
