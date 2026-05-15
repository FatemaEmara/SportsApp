//
//  Mocking.swift
//  IOS_UnitTestingDay2Tests
//
//  Created by Asmaa Ghonaim on 13/05/2026.
//

import XCTest

final class Mocking: XCTestCase {
    var FakeNetworkObj = FakeNetwork(shouldReturnWithError: false)
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testMocking()
    {
        
        let expectation = expectation(description: "loadData completion called")
        
        FakeNetworkObj.loadData(url: "") { league, error in
            
            if let error = error {
                XCTFail()
            } else {
                XCTAssertNotNil(league)
                XCTAssertTrue(league?.count != 0)
                
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        
        
        
    }
    
}
