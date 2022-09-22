//
//  ValidationService.swift
//  Esfenja
//
//  Created by ProjectEgy on 18/08/2022.
//

import Foundation

@available(iOS 13.0, *)
struct ValidationService {
    func validateUsername(_ username:String?) throws -> String{
        guard let username = username, username != "" else {throw ValidationError.requiredUsername}
        guard username.count > 3 else{throw ValidationError.shortUsername}
        guard username.count < 20 else{throw ValidationError.longUsername}
        return username
    }
    
    func validatePassword(_ password:String?) throws -> String{
        guard let password = password, password != "" else {throw ValidationError.requiredPassword}
        guard password.count >= 6 else{throw ValidationError.shortPassword}
        return password
    }
    
    func validateConfirmPassword(_ confirmPassword:String?) throws -> String{
        guard let confirmPassword = confirmPassword, confirmPassword != "" else {throw ValidationError.requiredConfirmPassword}
        return confirmPassword
    }
    
    func validatePhoneNumber(_ number:String?) throws -> String{
        
        guard let number = number else {throw ValidationError.invalidPhoneNumber}
        guard number != "" else {throw ValidationError.requiredPhoneNumber}
        let set = CharacterSet(charactersIn: number)
        guard CharacterSet.decimalDigits.isSuperset(of: set) else {throw ValidationError.phoneIsDigitsOnly}
        guard number.count > 5 else{throw ValidationError.shortPhoneNumber}
        guard number.count < 15 else{throw ValidationError.longtPhoneNumber}
        return number
    }
    
    func compareTwoPasswords(_ password:String?, _ confirmPassword:String?) throws -> String{
        guard let password = password, let confirmPassword = confirmPassword
        else{
            throw ValidationError.requiredPasswordAndItsConfirm
        }
                
        guard password == confirmPassword else {
            throw ValidationError.passwordAndConfirmPasswordDoesNotMatch
        }

        return password
    }
    
    func validateStrongPassword(_ password:String?) throws ->String{
        guard let password = password else {
            throw ValidationError.requiredPassword
        }

        let strongPasswordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", strongPasswordRegEx)
        guard  passwordPred.evaluate(with: password) == true else{
            throw ValidationError.weakPassword
        }
        return password
    }
    
    func validateEmail(_ email:String?) throws ->String{
        guard let email = email else {throw ValidationError.requiredEmail}
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard  emailPred.evaluate(with: email) == true else{ throw ValidationError.invalidEmail }
        return email
    }
    
}
