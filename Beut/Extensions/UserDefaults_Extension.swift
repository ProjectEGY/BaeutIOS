//
//  UserDefaults.swift
//  Esfenja
//
//  Created by ProjectEgy on 08/07/2022.
//

import Foundation

extension UserDefaults{
    
    func readUserInfoFromoUserDefaults(key:String)->User?{
        var result:User?
        if let userData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let userInfo = try? decoder.decode(User.self, from: userData){
                result = userInfo
            }
           
    }
        return result
    }
    
    func saveUsetInfoToUserDefaults(data:User?, key:String){
        let encoder = JSONEncoder()
        guard let data = data else {return}

        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func saveCurrentUsetLocation(data:CurrentLocation, key:String){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    func readCurrentUserLocation(key:String)->CurrentLocation?{
        var result:CurrentLocation?
        if let userData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let userInfo = try? decoder.decode(CurrentLocation.self, from: userData){
                result = userInfo
            }
           
    }
        return result
    }
    
    
    private enum UserDefaultsKeys:String{
        case hasOnboarded
        case isUserLoggedInt
        case didUserSelectCity
        case areaId
        case currentSelectedArea
    }
    
  
    
    var hasOnboarded:Bool{
        get{
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        
        
        }
    }
    
    //To indecate if user is logged in out not.
    var isUserLoggedInt:Bool{
        get{
            bool(forKey: UserDefaultsKeys.isUserLoggedInt.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultsKeys.isUserLoggedInt.rawValue)
        
        
        }
    }
    
    var didUserSelectCity:Bool{
        get{
            bool(forKey: UserDefaultsKeys.didUserSelectCity.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefaultsKeys.didUserSelectCity.rawValue)
        
        
        }
    }
    var areaId: Int? {
           get {
               return UserDefaults.standard.object(forKey: UserDefaultsKeys.areaId.rawValue) as? Int
           }
           set {
               UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.areaId.rawValue)
           }
       }
    
    var currentSelectedArea: String? {
           get {
               return UserDefaults.standard.object(forKey: UserDefaultsKeys.currentSelectedArea.rawValue) as? String
           }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.currentSelectedArea.rawValue)
        }
       }
   
}
