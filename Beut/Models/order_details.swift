//
//  OrderDetails_Model.swift
//  Esfenja
//
//  Created by ProjectEgy on 26/07/2022.
//

import Foundation

// MARK: - OrderDetails
struct OrderDetails: Decodable {
    let orderID: Int?
    let createDate, createTime: String?
    let deliverDate, deliverTime: String?
    let code: String?
    let storeID: Int?
    let storeImageURL, storeName, subTotal, total: String?
    let deliveryFees: String?
    let hasDriver: Bool?
    let driverID, driverName, driverPhoneNumber, driverImageURL: String?
    let driverRate: String?
    let canCallDriver: Bool?
    let getDriverOrdersCount: Int?
    let orderStatus: String?
    let paymentMethod: Int?
    let paymentMethodText: String?
    let userAddress: UserAddress?
    let canReviewDriver: Bool?
    let userDriverReview: String?
    let userDriverRate: Int?
    let canReviewStore: Bool?
    let userStoreReview: String?
    let userStoreRate: Int?
    let items: [BasketItem]?
    let canCancel: Bool?
    let discountPoint: Int?
    let now: Bool?
    let dayMonthYear, time: String?

    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case userAddress = "UserAddress"
        case orderID = "OrderId"
        case createDate = "CreateDate"
        case createTime = "CreateTime"
        case deliverDate = "DeliverDate"
        case deliverTime = "DeliverTime"
        case code = "Code"
        case storeID = "StoreId"
        case storeImageURL = "StoreImageUrl"
        case storeName = "StoreName"
        case subTotal = "SubTotal"
        case total = "Total"
        case deliveryFees = "DeliveryFees"
        case hasDriver = "HasDriver"
        case driverID = "DriverId"
        case driverName = "DriverName"
        case driverPhoneNumber = "DriverPhoneNumber"
        case driverImageURL = "DriverImageUrl"
        case driverRate = "DriverRate"
        case canCallDriver = "CanCallDriver"
        case getDriverOrdersCount
        case orderStatus = "OrderStatus"
        case paymentMethod = "PaymentMethod"
        case paymentMethodText = "PaymentMethodText"
        case canReviewDriver = "CanReviewDriver"
        case userDriverReview = "UserDriverReview"
        case userDriverRate = "UserDriverRate"
        case canReviewStore = "CanReviewStore"
        case userStoreReview = "UserStoreReview"
        case userStoreRate = "UserStoreRate"
        case canCancel = "CanCancel"
        case discountPoint
        case now = "Now"
        case dayMonthYear = "DayMonthYear"
        case time = "Time"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderID = try values.decodeIfPresent(Int.self, forKey: .orderID)
        createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
        createTime = try values.decodeIfPresent(String.self, forKey: .createTime)
        deliverDate = try values.decodeIfPresent(String.self, forKey: .deliverDate)
        deliverTime = try values.decodeIfPresent(String.self, forKey: .deliverTime)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        storeID = try values.decodeIfPresent(Int.self, forKey: .storeID)
        storeImageURL = try values.decodeIfPresent(String.self, forKey: .storeImageURL)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        deliveryFees = try values.decodeIfPresent(String.self, forKey: .deliveryFees)
        hasDriver = try values.decodeIfPresent(Bool.self, forKey: .hasDriver)
        driverID = try values.decodeIfPresent(String.self, forKey: .driverID)
        driverName = try values.decodeIfPresent(String.self, forKey: .driverName)
        driverPhoneNumber = try values.decodeIfPresent(String.self, forKey: .driverPhoneNumber)
        driverImageURL = try values.decodeIfPresent(String.self, forKey: .driverImageURL)
        driverRate = try values.decodeIfPresent(String.self, forKey: .driverRate)
        canCallDriver = try values.decodeIfPresent(Bool.self, forKey: .canCallDriver)
        getDriverOrdersCount = try values.decodeIfPresent(Int.self, forKey: .getDriverOrdersCount)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        paymentMethod = try values.decodeIfPresent(Int.self, forKey: .paymentMethod)
        paymentMethodText = try values.decodeIfPresent(String.self, forKey: .paymentMethodText)
        userAddress = try values.decodeIfPresent(UserAddress.self, forKey: .userAddress)
        canReviewDriver = try values.decodeIfPresent(Bool.self, forKey: .canReviewDriver)
        userDriverReview = try values.decodeIfPresent(String.self, forKey: .userDriverReview)
        userDriverRate = try values.decodeIfPresent(Int.self, forKey: .userDriverRate)
        canReviewStore = try values.decodeIfPresent(Bool.self, forKey: .canReviewStore)
        userStoreReview = try values.decodeIfPresent(String.self, forKey: .userStoreReview)
        userStoreRate = try values.decodeIfPresent(Int.self, forKey: .userStoreRate)
        items = try values.decodeIfPresent([BasketItem].self, forKey: .items)
        canCancel = try values.decodeIfPresent(Bool.self, forKey: .canCancel)
        discountPoint = try values.decodeIfPresent(Int.self, forKey: .discountPoint)
        now = try values.decodeIfPresent(Bool.self, forKey: .now)
        dayMonthYear = try values.decodeIfPresent(String.self, forKey: .dayMonthYear)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }
}

