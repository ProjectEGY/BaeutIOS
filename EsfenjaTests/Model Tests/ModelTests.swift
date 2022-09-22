//
//  ModelTests.swift
//  EsfenjaTests
//
//  Created by ProjectEgy on 18/08/2022.
//

import XCTest
@testable import Esfenja

class ModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func test_response_errors()throws{
        

        let expectedError = AppError.timeOut
        
        
        let error = URLError(.timedOut, userInfo: ["Error":"error"]) as Error

        
        guard let result = ResponseHandler.shared.handleResponseErrors(response: nil, error: error) else{return}
        
        XCTAssertEqual(result.localizedDescription, expectedError.localizedDescription)
}
    func test_jwt() throws {
        let jwt = JWT.shared.getJWT()
        XCTAssertNotNil(jwt)
    }
    
}
