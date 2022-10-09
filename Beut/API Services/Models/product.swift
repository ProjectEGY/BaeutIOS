//
//  Packages_Model.swift
//  Esfenja
//
//  Created by ProjectEgy on 19/07/2022.
//

import Foundation

struct ProductModel:Decodable{
    let productId:Int?
    let name:String?
    let description:String?
    let isMultipleSize:Bool?
    let singleOriginalPrice:String?
    let singleOfferPrice:String?
    let storeId:Int?
    let storeName:String?
    let images:[String]?
    let sizes:[Size]?
    let optionModifiers:[Options]?
    
    enum CodingKeys: String, CodingKey {
        case productId = "ProductId"
        case name = "Name"
        case description = "Description"
        case isMultipleSize = "IsMultipleSize"
        case singleOriginalPrice = "SingleOriginalPrice"
        case singleOfferPrice = "SingleOfferPrice"
        case storeId = "StoreId"
        case storeName = "StoreName"
        case images = "Images"
        case sizes = "Sizes"
        case optionModifiers = "OptionModifiers"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        isMultipleSize = try values.decodeIfPresent(Bool.self, forKey: .isMultipleSize)
        singleOriginalPrice = try values.decodeIfPresent(String.self, forKey: .singleOriginalPrice)
        singleOfferPrice = try values.decodeIfPresent(String.self, forKey: .singleOfferPrice)
        storeId = try values.decodeIfPresent(Int.self, forKey: .storeId)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        sizes = try values.decodeIfPresent([Size].self, forKey: .sizes)
        optionModifiers = try values.decodeIfPresent([Options].self, forKey: .optionModifiers)
    }

    
}

struct Options:Decodable{
    let id:Int?
    let name:String?
    let price:Double?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case price = "Price"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        
    }
}

struct Size:Decodable{
    let sizeId:Int?
    let name:String?
    let originalPrice:String?
    let offerPrice:String?
    
    enum CodingKeys: String, CodingKey {
        case sizeId = "SizeId"
        case name = "Name"
        case originalPrice = "OriginalPrice"
        case offerPrice = "OfferPrice"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sizeId = try values.decodeIfPresent(Int.self, forKey: .sizeId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        originalPrice = try values.decodeIfPresent(String.self, forKey: .originalPrice)
        offerPrice = try values.decodeIfPresent(String.self, forKey: .offerPrice)
        
    }
}
