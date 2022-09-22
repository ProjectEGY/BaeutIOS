//
//  Categories.swift
//  Esfenja
//
//  Created by ProjectEgy on 29/06/2022.
//

import Foundation
import UIKit
struct Categories: Decodable {
    let id: Int?
    let name, imageURL: String?
    let isOpen, isDaily:Bool?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imageURL = "ImageUrl"
        case isOpen = "IsOpen"
        case isDaily = "IsDaily"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
        isDaily = try values.decodeIfPresent(Bool.self, forKey: .isDaily)
    }
}
struct CategoryWithId{
    let marketName:String
    let marketImage:UIImage
    let marketLocation:String
    let markeDetails:String
    let marketRating:String
}
