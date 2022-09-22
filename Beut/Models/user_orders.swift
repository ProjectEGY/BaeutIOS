//
//  UserOrders.swift
//  Esfenja
//
//  Created by ProjectEgy on 25/07/2022.
//

import Foundation
// MARK: - PreviousOrder

struct Orders: Decodable {
    let orderType, orderID: Int?
    let isStoreOrder: Bool?
    let storeName:String?
    let otlobAy7AgaImageURL, jobOrderImageURL: String?
    let deliveryFees, subTotal, total: Double?
    let address, orderCode, orderDate, orderStatus: String?
    let createdOn: String?
    let storeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case orderType = "OrderType"
        case orderID = "OrderId"
        case isStoreOrder = "IsStoreOrder"
        case storeName = "StoreName"
        case storeImageURL = "StoreImageUrl"
        case otlobAy7AgaImageURL = "OtlobAy7agaImageUrl"
        case jobOrderImageURL = "JobOrderImageUrl"
        case deliveryFees = "DeliveryFees"
        case subTotal = "SubTotal"
        case total = "Total"
        case address = "Address"
        case orderCode = "OrderCode"
        case orderDate = "OrderDate"
        case orderStatus = "OrderStatus"
        case createdOn = "CreatedOn"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderType = try values.decodeIfPresent(Int.self, forKey: .orderType)
        orderID = try values.decodeIfPresent(Int.self, forKey: .orderID)
        isStoreOrder = try values.decodeIfPresent(Bool.self, forKey: .isStoreOrder)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        otlobAy7AgaImageURL = try values.decodeIfPresent(String.self, forKey: .otlobAy7AgaImageURL)
        jobOrderImageURL = try values.decodeIfPresent(String.self, forKey: .jobOrderImageURL)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        deliveryFees = try values.decodeIfPresent(Double.self, forKey: .deliveryFees)
        subTotal = try values.decodeIfPresent(Double.self, forKey: .subTotal)
        total = try values.decodeIfPresent(Double.self, forKey: .total)
        orderCode = try values.decodeIfPresent(String.self, forKey: .orderCode)
        orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
        createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
        storeImageURL = try values.decodeIfPresent(String.self, forKey: .storeImageURL)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
    }
}
