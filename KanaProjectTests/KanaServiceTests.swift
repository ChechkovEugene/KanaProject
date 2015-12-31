//
//  KanaServiceTests.swift
//  KanaProject
//
//  Created by Eugene Chechkov on 3/3/15.
//  Copyright (c) 2015 Eugene Chechkov. All rights reserved.
//

import XCTest

class KanaServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGenerateRandomNumberWithUpperBound() {
        XCTAssertTrue(KanaService.generateRandomNumberWithUpperBound(111) <= 111, "Should return number with upper bound" )
    }

    func testGenerateRandoms() {
        let result = KanaService.generateRandoms(10, upperBound: 10)
        XCTAssertTrue(result.count == 10, "Should create 10 elements array")
        
        for elem in result {
            XCTAssertTrue(elem <= 10, "Element should be less than 10")
        }
    }

}
