//
//  StoreDetails.swift
//  Esfenja
//
//  Created by ProjectEgy on 17/07/2022.
//

import Foundation


struct StoreDetails:Decodable{
    let id:Int?
    let name:String?
    let coverImageUrl:String?
    let logoImageUrl:String?
    let description:String?
    let phoneNumber:String?
    let address:String?
    let latitude:Double?
    let longitude:Double?
    let seenCount:Int?
    let isOpen:Bool?
    let rate:String?
    let categories:[Categs]?
//    let IsFav:Bool
//    let HasOffers:Bool
//    let OpenFarCost:Double
//    let DeliveryBySystem:Bool
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case coverImageUrl = "CoverImageUrl"
        case logoImageUrl = "LogoImageUrl"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case description = "Description"
        case phoneNumber = "PhoneNumber"
        case address = "Address"
        case seenCount = "SeenCount"
        case isOpen = "IsOpen"
        case rate = "Rate"
        case categories = "Categories"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        coverImageUrl = try values.decodeIfPresent(String.self, forKey: .coverImageUrl)
        logoImageUrl = try values.decodeIfPresent(String.self, forKey: .logoImageUrl)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        seenCount = try values.decodeIfPresent(Int.self, forKey: .seenCount)
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        categories = try values.decodeIfPresent([Categs].self, forKey: .categories)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}


struct Categs:Decodable{
    let categoryId:Int?
    let name:String?
    let imageUrl:String?
    let products:[CustomProduct]?
    enum CodingKeys: String, CodingKey {
        case categoryId = "CategoryId"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case products = "Products"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        products = try values.decodeIfPresent([CustomProduct].self, forKey: .products)
        
    }
}

struct CustomProduct:Decodable{
    let id:Int
    let name:String
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        
    }
}
