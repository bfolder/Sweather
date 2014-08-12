//
//  SweatherTests.swift
//  SweatherTests
//
//  Created by Heiko Dreyer on 08/12/14.
//  Copyright (c) 2014 boxedfolder.com. All rights reserved.
//

import UIKit
import XCTest

class SweatherTests: XCTestCase {
    var client:Sweather!;
    
    override func setUp() {
        super.setUp()
        client = Sweather(apiKey: "1234", language: "sp", temperatureFormat: Sweather.TemperatureFormat.Celcius, apiVersion: "2.4");
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(client.language, "sp")
        XCTAssertEqual(client.apiKey, "1234");
        XCTAssertEqual(client.temperatureFormat, Sweather.TemperatureFormat.Celcius)
        XCTAssertEqual(client.apiVersion, "2.4")
    }
}
