//
//  Route.swift
//  Esfenja
//
//  Created by ProjectEgy on 03/07/2022.
//

import Foundation

enum Route {
    static let baseUrl = "http://beaut-jo.com"
    case fetchAllCategories
    case getSliderData
    case signUp
    case verifyAccount
    case logIn
    case changePassword
    case storeDetails
    case getAllStoresByCategoryID
    case getPackages
    case getProductByCategoryID
    case getBasket
    case removeBasketItem
    case increaseItem
    case decreaseItem
    case checkOut
    case addNewAddress
    case saveAddressToOrder
    case previousOrders
    case currentOrders
    case addToBasket
    case search
    case orderDetails
    case complaints
    case changeCity
    case pushNotifications
    case updateProfile
    case getCashPoints
    case forgetPassword
    case offers
    case contactUs
    var description: String {
        switch self {
        case .fetchAllCategories:
            return "/api/categories/GetAll"
        case .getSliderData:
            return "/Api/Slider/Get"
        case .signUp:
            return "/api/Account/Register"
        case .verifyAccount:
            return "/api/Account/VerifyAccount"
        case .logIn:
            return "/api/Account/Login"
        case .changePassword:
            return "/api/Account/ChangePassword"
        case .storeDetails:
            return "/api/stores/Details"
        case .getAllStoresByCategoryID:
            return "/api/stores/GetAll"
        case .getPackages:
            return "/api/products/Offers"
        case .getProductByCategoryID:
            return "/api/stores/StoreProducts"
        case .addToBasket:
            return "/api/storeOrders/addtobasket"
        case .getBasket:
            return "/api/storeOrders/basket"
        case .removeBasketItem:
            return "/api/storeOrders/delete"
        case .increaseItem:
            return "/api/storeOrders/increase"
        case .decreaseItem:
            return "/api/storeOrders/decrease"
        case .checkOut:
            return "/api/storeOrders/checkout"
        case .addNewAddress:
            return "/api/UserAddresses"
        case .saveAddressToOrder:
            return "/api/account/SaveAddressToOrder"
        case .previousOrders:
            return "/api/common/Orders/previoususer"
        case .currentOrders:
            return "/api/common/Orders/currentuser"
        case .search:
            return "/api/Stores/ProductsFilter"
        case .orderDetails:
            return "/api/storeOrders/Details"
        case .complaints:
            return "/api/Complaints"
        case .changeCity:
            return "/api/Countries"
        case .pushNotifications:
            return "/api/PushTokens/get"
        case .updateProfile:
            return "/api/Account/UpdateProfile"
        case .getCashPoints:
            return "/api/storeOrders/GEtCashPoint"
        case .forgetPassword:
            return "/api/Account/ForgotPassword"
        case .offers:
            return "/api/products/Offers"
        case .contactUs:
            return "/api/company/about"
        }
    }
}
