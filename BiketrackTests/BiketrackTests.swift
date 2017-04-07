//
//  BiketrackTests.swift
//  BiketrackTests
//
//  Created by Valentin Wallet on 13/10/2016.
//  Copyright © 2016 Biketrack. All rights reserved.
//

import XCTest
@testable import Biketrack

class BiketrackTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInitBike() {
        let bike = Bike(image: "http://www.google.fr/fixie.jpg", title: "fixie", lat: 1, long: 2)
        XCTAssertEqual("http://www.google.fr/fixie.jpg", bike.image)
        XCTAssertEqual("fixie", bike.title)
        XCTAssertEqual(1, bike.lat)
        XCTAssertEqual(2, bike.long)
    }
    
}
