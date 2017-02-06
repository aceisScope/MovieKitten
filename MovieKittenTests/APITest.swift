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
    
    func testSearchAPICallback() {
        let exp = expectation(description: "Search API returns data in callback")

        APIWrapper.search(title: "cat", completion: { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            exp.fulfill()
        })
            
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("waitForExpectations timeout errored: \(error)")
            }
        }
    }

    func testDetailAPICallback() {
        let exp = expectation(description: "Detail API returns data in callback")

        APIWrapper.detail(imdbID: "tt0076759", completion: { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            exp.fulfill()
        })

        waitForExpectations(timeout: 20) { error in
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
