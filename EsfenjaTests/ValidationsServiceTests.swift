//
//  ValidationsServiceTests.swift
//  EsfenjaTests
//
//  Created by ProjectEgy on 18/08/2022.
//
@testable import Esfenja
import XCTest

class ValidationsServiceTests: XCTestCase {

    var validation:ValidationService!
    override func setUp() {
        validation = ValidationService()
        super.setUp()
    }
    
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    //Testing username validation
    func test_username_happy_pass()throws{
        XCTAssertNoThrow(try validation.validateUsername("fdsd"))
    }
    func test_username_is_nil()throws{
        let expectedError = ValidationError.requiredUsername
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateUsername(nil)){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_username_is_too_short()throws{
        let expectedError = ValidationError.shortUsername
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateUsername("d")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_username_is_too_long()throws{
        let expectedError = ValidationError.longUsername
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateUsername("this is a very long user name")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    
    //Testing password validation
    func test_password_happy_pass()throws{
        XCTAssertNoThrow(try validation.validatePassword("fdsdsdd"))
        XCTAssertNoThrow(try validation.validateConfirmPassword("fdsdsdd"))
    }
    func test_password_is_nil()throws{
        let expectedError = ValidationError.requiredPassword
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePassword(nil)){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_password_is_too_short()throws{
        let expectedError = ValidationError.shortPassword
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePassword("d")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    //Testing confirm password validation
    func test_confirm_password_is_nil()throws{
        let expectedError = ValidationError.requiredConfirmPassword
        var error:ValidationError?
       
        XCTAssertThrowsError(try validation.validateConfirmPassword(nil)){
            thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    
    
    
    //Testing phone number validation
    
    func test_phone_number_happy_pass()throws{
       
        XCTAssertNoThrow(try validation.validatePhoneNumber("011111111"))
    }
    
    func test_is_phone_number_contains_digits_only()throws{
        let expectedError = ValidationError.phoneIsDigitsOnly
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePhoneNumber("fdsd")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
  
    func test_phone_number_is_nil()throws{
        let expectedError = ValidationError.invalidPhoneNumber
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePhoneNumber(nil)){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_phone_number_is_empty()throws{
        let expectedError = ValidationError.requiredPhoneNumber
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePhoneNumber("")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_phone_number_is_too_short()throws{
        let expectedError = ValidationError.shortPhoneNumber
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePhoneNumber("5")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_phone_number_is_too_long()throws{
        let expectedError = ValidationError.longtPhoneNumber
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validatePhoneNumber("1111111111111111111")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    //Testing compare two passwords
    
    func test_two_passwords_are_not_equals()throws{
        let expectedError = ValidationError.passwordAndConfirmPasswordDoesNotMatch
        var error:ValidationError?
        XCTAssertThrowsError(try validation.compareTwoPasswords("123", "589")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_two_passwords_are_equals_happy_pass()throws{
       
        XCTAssertNoThrow(try validation.compareTwoPasswords("123", "123"))
    }
    
    func test_two_passwords_are_nil()throws{
        let expectedError = ValidationError.requiredPasswordAndItsConfirm
        var error:ValidationError?
        XCTAssertThrowsError(try validation.compareTwoPasswords(nil, "589")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    
    //Testing email validation
    func test_email_happy_pass()throws{
        XCTAssertNoThrow(try validation.validateEmail("user@example.com"))
    }
    
    func test_email_is_nil()throws{
        let expectedError = ValidationError.requiredEmail
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateEmail(nil)){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_email_is_valid()throws{
        let expectedError = ValidationError.invalidEmail
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateEmail("wrongemail.com")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    //Testing strong password validation
    func test_strong_password_happy_pass()throws{
        XCTAssertNoThrow(try validation.validateStrongPassword("PassC56@#"))
    }
    
    func test_strong_password_is_nil()throws{
        let expectedError = ValidationError.requiredPassword
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateStrongPassword(nil)){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_is_strong_password()throws{
        let expectedError = ValidationError.weakPassword
        var error:ValidationError?
        XCTAssertThrowsError(try validation.validateStrongPassword("14")){
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(error, expectedError)
        XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
    }

    
}
