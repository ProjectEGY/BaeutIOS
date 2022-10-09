//
//  GenralResponse.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/07/2022.
//

import Foundation
struct GeneralResponse<T:Decodable>:Decodable {
    let errorCode: Int?
    let errorMessage: String?
    let data:T?
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
     
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
}
