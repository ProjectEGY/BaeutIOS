//
//  AccountInfo.swift
//  Esfenja
//
//  Created by ProjectEgy on 10/07/2022.
//

import Foundation

struct User:Codable{
    let id:String?
    let name: String?
    let email:String?
    let phone:String?
    let latitude:Double?
    let longitude:Double?
    let image:String?
    var token:String?
    let wallet:Double?
    let isExternal:Bool?
    let shareUserId:Int?
    let point:Double?
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case email = "Email"
        case phone = "Phone"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case image = "Image"
        case token = "Token"
        case wallet = "Wallet"
        case isExternal = "IsExternal"
        case point = "Point"
        case shareUserId = "ShareUserId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        wallet = try values.decodeIfPresent(Double.self, forKey: .wallet)
        isExternal = try values.decodeIfPresent(Bool.self, forKey: .isExternal)
        shareUserId = try values.decodeIfPresent(Int.self, forKey: .shareUserId)
        point = try values.decodeIfPresent(Double.self, forKey: .point)
    }
}
