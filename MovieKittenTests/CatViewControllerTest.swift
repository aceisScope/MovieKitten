//
//  CatViewControllerTest.swift
//  MovieKitten
//
//  Created by Binghui Liu on 06/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import XCTest
@testable import MovieKitten

class CatViewControllerTest: XCTestCase {

    var viewController: CatViewController!
    
    override func setUp() {
        super.setUp()

        viewController = CatViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRandomSearchString() {
        let keyword = viewController.randomSearch()
        XCTAssertNotNil(keyword)
    }
    
}
