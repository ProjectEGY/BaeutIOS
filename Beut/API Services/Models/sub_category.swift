//
//  StoreByCategory.swift
//  Esfenja
//
//  Created by ProjectEgy on 18/07/2022.
//

import Foundation
struct SubCategoryModel:Decodable{
    let id:Int?
    let name:String?
    let imageUrl:String?
    let description:String?
    let isOpen:Bool?
    let address:String?
    let rate:String?
    let storesDate:Date?
    let optionModifiers:String?
    let distance:DistanceStruct?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case storesDate = "StoresDate"
        case description = "Description"
        case address = "Address"
        case isOpen = "IsOpen"
        case rate = "Rate"
        case optionModifiers = "OptionModifiers"
        case distance = "Distance"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        storesDate = try values.decodeIfPresent(Date.self, forKey: .storesDate)
        optionModifiers = try values.decodeIfPresent(String.self, forKey: .optionModifiers)
        distance = try values.decodeIfPresent(DistanceStruct.self, forKey: .distance)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}

struct DistanceStruct:Decodable{
    let totalEstimatedDistance:String?
    let totalEstimatedTime:String?
    enum CodingKeys:String, CodingKey{
        case totalEstimatedDistance = "TotalEstimatedDistance"
        case totalEstimatedTime = "TotalEstimatedTime"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalEstimatedDistance = try values.decodeIfPresent(String.self, forKey: .totalEstimatedDistance)
        totalEstimatedTime = try values.decodeIfPresent(String.self, forKey: .totalEstimatedTime)
       
    }
}
