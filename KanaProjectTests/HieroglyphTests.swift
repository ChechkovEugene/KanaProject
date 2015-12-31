//
//  KanaProjectTests.swift
//  KanaProjectTests
//
//  Created by Eugene Chechkov on 2/20/15.
//  Copyright (c) 2015 Eugene Chechkov. All rights reserved.
//

import XCTest

class HieroglyphTests: XCTestCase {
    
    var hieroglyph:Hieroglyph?
    
    override func setUp() {
        super.setUp()
        hieroglyph = Hieroglyph(code: 1, name: "TestHiero")
    }
    
    override func tearDown() {
        hieroglyph = nil
        super.tearDown()
    }
    
    func testHieroglyphNotNil() {
        XCTAssertNotNil(hieroglyph, "Hiero object must be not nil")
    }
    
    func testCodeEquality() {
     XCTAssertTrue(hieroglyph?.code == 1, "Code should be equals 1")
    }
    
    func testNameEquality() {
        XCTAssertTrue(hieroglyph?.name == "TestHiero", "Name should be equals 1")
    }
    
}
