//
//  AppErrors.swift
//  Esfenja
//
//  Created by ProjectEgy on 03/07/2022.
//
//"Server is un available now"
//"Response could not be decoded"
import Foundation

@available(iOS 13.0, *)
enum AppError: LocalizedError{
    case errorDecoding
    case unknownError
    case invalidUrl
    case timeOut
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "errorDecoding".localized
        case .unknownError:
            return "unknownError".localized
        case .invalidUrl:
            return "Give me a valid URL"
        case .serverError(let error):
            return error
       
        case .timeOut:
            return "timeOut".localized
        }
    }
}
