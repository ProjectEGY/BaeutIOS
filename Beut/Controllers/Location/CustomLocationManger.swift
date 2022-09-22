//
//  CustomLocationManger.swift
//  Mahara - مهارة
//
//  Created by ProjectEgy on 29/08/2022.
//

import UIKit
import Kingfisher
import CoreLocation
struct Place{
    let name:String
    let id:String
}
class GooglePlacesManger {
    
    static let shared = GooglePlacesManger()
    private init(){}
    private let client = GMSPlacesClient.shared()
    
    public func findPlaces(query:String, completion:@escaping(Result<[Place], Error>)->Void){
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil){
            (results, error) in
            guard let results = results, error == nil else{
                completion(.failure(error!))
                return
            }
            print("DD:\(results)")
            let places:[Place] = results.compactMap({
                Place(name: $0.attributedFullText.string, id: $0.placeID)
            })
            completion(.success(places))
            
        }
    }
    
    public func getLocationCoordinates(place:Place, completion:@escaping(Result<CLLocationCoordinate2D, Error>)->Void){
        client.fetchPlace(fromPlaceID: place.id, placeFields: .coordinate, sessionToken: nil){
            (googlePlace, error) in
            guard let googlePlace = googlePlace, error == nil else
            {
                completion(.failure(error!))
                return
            }
            let coordinates = CLLocationCoordinate2D(latitude: googlePlace.coordinate.latitude, longitude: googlePlace.coordinate.longitude)
            
            completion(.success(coordinates))
        }
    }
    
    
    
}
