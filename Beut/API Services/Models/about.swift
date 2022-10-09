//
//  about.swift
//  Beut
//
//  Created by ProjectEgy on 26/09/2022.
//

import Foundation

struct AboutInfo: Codable {
    let phone, email, address, whatsApp, twitter, instagram, facebook:String?

    enum CodingKeys: String, CodingKey {
        case phone = "Phone"
        case email = "Email"
        case address = "Address"
        case whatsApp = "WhatsApp"
        case twitter = "Twitter"
        case instagram = "Instagram"
        case facebook = "Facebook"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        phone = try values.decodeIfPresent( String.self, forKey: .phone)
        email = try values.decodeIfPresent( String.self, forKey: .email)
        address = try values.decodeIfPresent( String.self, forKey: .address)
        whatsApp = try values.decodeIfPresent( String.self, forKey: .whatsApp)
        twitter = try values.decodeIfPresent( String.self, forKey: .twitter)
        instagram = try values.decodeIfPresent( String.self, forKey: .instagram)
        facebook = try values.decodeIfPresent( String.self, forKey: .facebook)
    }
}
