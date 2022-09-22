//
//  APIResponse.swift
//  Esfenja
//
//  Created by ProjectEgy on 03/07/2022.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let ErrorCode: Int
    let ErrorMessage: String?
    let Data: T?
    let error:String?
}
