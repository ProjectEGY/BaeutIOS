//
//  SearchModel.swift
//  Esfenja
//
//  Created by ProjectEgy on 26/07/2022.
//

import Foundation

struct SearchResult:Decodable{
    let id: Int?
    let nameAr, imageURL, searchDescription: String?
    let isOpen: Bool?
    let address: String?
    let rate: Double?
    let nameEn: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nameAr = "NameAr"
        case imageURL = "ImageUrl"
        case searchDescription = "Description"
        case isOpen = "IsOpen"
        case address = "Address"
        case rate = "Rate"
        case nameEn = "NameEn"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        nameAr = try values.decodeIfPresent(String.self, forKey: .nameAr)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        searchDescription = try values.decodeIfPresent(String.self, forKey: .searchDescription)
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        nameEn = try values.decodeIfPresent(String.self, forKey: .nameEn)
    }
}
