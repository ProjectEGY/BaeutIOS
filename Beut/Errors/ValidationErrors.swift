//
//  ValidationErrors.swift
//  Esfenja
//
//  Created by ProjectEgy on 18/08/2022.
//

import Foundation
@available(iOS 13.0, *)
enum ValidationError: LocalizedError {
    
    //username validation errors
    case requiredUsername
    case shortUsername
    case longUsername
    
    //password validation errors
    case requiredPassword
    case shortPassword
    
    //confirm password
    case requiredConfirmPassword
    case passwordAndConfirmPasswordDoesNotMatch
    case requiredPasswordAndItsConfirm
    
    //phone number validation errors
    case requiredPhoneNumber
    case invalidPhoneNumber
    case shortPhoneNumber
    case phoneIsDigitsOnly
    case longtPhoneNumber
    
    //Strong password validation
    case weakPassword
    
    //Email validation
    case invalidEmail
    case requiredEmail
    
    var errorDescription: String? {
        switch self {
        case .requiredUsername:
            return "requiredUsername".localized
        case .shortUsername:
            return "shortUsername".localized
        case .longUsername:
            return "longUsername".localized
        case .requiredPassword:
            return "requiredPassword".localized
        case .shortPassword:
            return "shortPassword".localized
        case .requiredPhoneNumber:
            return "requiredPhoneNumber".localized
        case .invalidPhoneNumber:
            return "invalidPhoneNumber".localized
        case .shortPhoneNumber:
            return "shortPhoneNumber".localized
        case .phoneIsDigitsOnly:
            return "phoneIsDigitsOnly".localized
        case .longtPhoneNumber:
            return "longtPhoneNumber".localized
        case .passwordAndConfirmPasswordDoesNotMatch:
            return "passwordAndConfirmPasswordDoesNotMatch".localized
        case .requiredConfirmPassword:
            return "requiredConfirmPassword".localized
        case .weakPassword:
            return "weakPassword".localized
        case .invalidEmail:
            return "invalidEmail".localized
        case .requiredPasswordAndItsConfirm:
            return "requiredPasswordAndItsConfirm".localized
        case .requiredEmail:
            return "requiredEmail".localized
        }
    }
}
