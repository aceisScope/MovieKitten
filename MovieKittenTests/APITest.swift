//
//  APITest.swift
//  MovieKitten
//
//  Created by Binghui Liu on 2017/2/1.
//  Copyright © 2017年 Binghui Liu. All rights reserved.
//

import XCTest
@testable import MovieKitten

class APITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPICallback() {
        let exp = expectation(description: "API wrapper returns data in callback")
        
        APIWrapper.test { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            exp.fulfill()
        }
            
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectations timeout errored: \(error)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
