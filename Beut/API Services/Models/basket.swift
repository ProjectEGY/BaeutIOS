//
//  Basket.swift
//  Esfenja
//
//  Created by ProjectEgy on 21/07/2022.
//

import Foundation

struct Basket: Decodable {
    let id: Int?
    let name, coverImageURL, logoImageURL: String?
    let basketDescription: String?
    let phoneNumber: String?
    let address: String?
    let latitude, longitude:Double?
    let seenCount: Int?
    let isOpen: Bool?
    let rate, subTotal, deliveryFees, total: String?
    let customerHasAddress: Bool?
    let userAddress: UserAddress?
    let userWallet: Int?
    let basketItems: [BasketItem]?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case coverImageURL = "CoverImageUrl"
        case logoImageURL = "LogoImageUrl"
        case basketDescription = "Description"
        case phoneNumber = "PhoneNumber"
        case address = "Address"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case seenCount = "SeenCount"
        case isOpen = "IsOpen"
        case rate = "Rate"
        case subTotal = "SubTotal"
        case deliveryFees = "DeliveryFees"
        case total = "Total"
        case customerHasAddress = "CustomerHasAddress"
        case userAddress = "UserAddress"
        case userWallet = "UserWallet"
        case basketItems = "BasketItems"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        coverImageURL = try values.decodeIfPresent(String.self, forKey: .coverImageURL)
        logoImageURL = try values.decodeIfPresent(String.self, forKey: .logoImageURL)
        basketDescription = try values.decodeIfPresent(String.self, forKey: .basketDescription)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        seenCount = try values.decodeIfPresent(Int.self, forKey: .seenCount)
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
        rate = try values.decodeIfPresent(String.self, forKey: .rate)
        subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
        deliveryFees = try values.decodeIfPresent(String.self, forKey: .deliveryFees)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        customerHasAddress = try values.decodeIfPresent(Bool.self, forKey: .customerHasAddress)
        userAddress = try values.decodeIfPresent(UserAddress.self, forKey: .userAddress)
        userWallet = try values.decodeIfPresent(Int.self, forKey: .userWallet)
        basketItems = try values.decodeIfPresent( [BasketItem].self, forKey: .basketItems)
       
    }
}

// MARK: - BasketItem
struct BasketItem: Decodable {
    let basketItemID: Int?
    let price, subTotal: String?
    let quantity: Int?
    let name: String?
    let basketItemDescription, image, size: String?
    let modifier: [String]?

    enum CodingKeys: String, CodingKey {
        case basketItemID = "BasketItemId"
        case price = "Price"
        case subTotal = "SubTotal"
        case quantity = "Quantity"
        case name = "Name"
        case basketItemDescription = "Description"
        case image = "Image"
        case size = "Size"
        case modifier = "Modifier"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        basketItemID = try values.decodeIfPresent(Int.self, forKey: .basketItemID)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        basketItemDescription = try values.decodeIfPresent(String.self, forKey: .basketItemDescription)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        modifier = try values.decodeIfPresent([String].self, forKey: .modifier)
    }
}

// MARK: - UserAddress
struct UserAddress: Decodable {
    let id: Int?
    let name: String?
    let latitude, longitude: Double?
    let address, floor, buildingNumber, apartment: String?
    let phoneNumber, addressInDetails: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case address = "Address"
        case floor = "Floor"
        case buildingNumber = "BuildingNumber"
        case apartment = "Apartment"
        case phoneNumber = "PhoneNumber"
        case addressInDetails = "AddressInDetails"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        floor = try values.decodeIfPresent(String.self, forKey: .floor)
        buildingNumber = try values.decodeIfPresent(String.self, forKey: .buildingNumber)
        apartment = try values.decodeIfPresent(String.self, forKey: .apartment)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        addressInDetails = try values.decodeIfPresent(String.self, forKey: .addressInDetails)
    }
}
