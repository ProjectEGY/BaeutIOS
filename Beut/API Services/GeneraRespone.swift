//
//  GeneraRespone.swift
//  Esfenja
//
//  Created by ProjectEgy on 21/07/2022.
//

import Foundation
struct Genral: Decodable {
    let ErrorCode: Int
    let ErrorMessage: String?
    let Data:String?
    
}

struct Genral2: Decodable {
    let ErrorCode: Int
    let ErrorMessage: String?
    let Data:Int?
    
}
