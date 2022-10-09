//
//  CountryAndCity.swift
//  Esfenja
//
//  Created by ProjectEgy on 27/07/2022.
//

import Foundation

struct Country: Decodable {
    let id: Int?
    let nameAr, nameEn:String?
    let flag: String?
    let areas: [Area]?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
        case flag = "Flag"
        case areas = "Areas"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        nameAr = try values.decodeIfPresent(String.self, forKey: .nameAr)
        flag = try values.decodeIfPresent(String.self, forKey: .flag)
        areas = try values.decodeIfPresent( [Area].self, forKey: .areas)
        nameEn = try values.decodeIfPresent(String.self, forKey: .nameEn)
    }
}

// MARK: - Area
struct Area: Decodable {
    let id, countryID: Int?
    let nameAr, nameEn: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case countryID = "CountryId"
        case nameAr = "NameAr"
        case nameEn = "NameEn"
    }
}
