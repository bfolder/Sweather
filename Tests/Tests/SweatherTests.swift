//
//  SweatherTests.swift
//  SweatherTests
//
//  Created by Heiko Dreyer on 08/12/14.
//  Copyright (c) 2014 boxedfolder.com. All rights reserved.
//

import UIKit
import CoreLocation
import XCTest

class SweatherTests: XCTestCase {
    var client:Sweather!;
    
    override func setUp() {
        super.setUp()
        client = Sweather(apiKey: "1234", language: "sp", temperatureFormat: .Celcius, apiVersion: "2.5")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(client.language, "sp")
        XCTAssertEqual(client.apiKey, "1234");
        XCTAssertEqual(client.temperatureFormat, Sweather.TemperatureFormat.Celcius)
        XCTAssertEqual(client.apiVersion, "2.5")
    }
    
    // MARK: -
    // MARK: Current weather
    
    func testCurrentWeatherByName() {
        let expectation = expectationWithDescription("currentWeatherByName")
        client.currentWeather("Berlin") { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/weather?q=Berlin&APPID=1234&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(data!["name"] as String, "Berlin")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testCurrentWeatherById() {
        let expectation = expectationWithDescription("currentWeatherById")
        client.currentWeather(2950159) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()!
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/weather?id=2950159&APPID=1234&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(data["name"] as String, "Berlin")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testCurrentWeatherByCoordinate() {
        let expectation = expectationWithDescription("currentWeatherById")
        client.currentWeather(CLLocationCoordinate2D(latitude: 52, longitude: 13)) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()!
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/weather?lat=52.0&lon=13.0&APPID=1234&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertNotNil(data["name"] as String)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    // MARK: Daily forecast
    
    func testDailyForecastByName() {
        let expectation = expectationWithDescription("dailyForecastByName")
        client.dailyForecast("Berlin") { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()! as Dictionary<String, AnyObject>
            let cityDict = data["city"]! as Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast/daily?q=Berlin&APPID=1234&lang=sp&units=metric", url!);
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"]! as String, "Berlin")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testDailyForecastById() {
        let expectation = expectationWithDescription("dailyForecastById")
        client.dailyForecast(2950159) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()! as Dictionary<String, AnyObject>
            let cityDict = data["city"]! as Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast/daily?id=2950159&APPID=1234&lang=sp&units=metric", url!);
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"]! as String, "Berlin")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testDailyForecastByCoordinate() {
        let expectation = expectationWithDescription("dailyForecastByCoordinate")
        client.dailyForecast(CLLocationCoordinate2D(latitude: 52, longitude: 13)) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()! as Dictionary<String, AnyObject>
            let cityDict = data["city"]! as Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast/daily?lat=52.0&lon=13.0&APPID=1234&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"]! as String, "Niedergorsdorf")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    // MARK: Forecast
    
    func testForecastByName() {
        let expectation = expectationWithDescription("dailyForecastByName")
        client.forecast("Berlin") { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()! as Dictionary<String, AnyObject>
            let cityDict = data["city"]! as Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast?q=Berlin&APPID=1234&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"]! as String, "Berlin")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testForecastById() {
        let expectation = expectationWithDescription("dailyForecastById")
        client.forecast(2950159) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()! as Dictionary<String, AnyObject>
            let cityDict = data["city"]! as Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast?id=2950159&APPID=1234&lang=sp&units=metric", url!);
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"]! as String, "Berlin")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testForecastByCoordinate() {
        let expectation = expectationWithDescription("dailyForecastByCoordinate")
        client.forecast(CLLocationCoordinate2D(latitude: 52, longitude: 13)) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()! as Dictionary<String, AnyObject>
            let cityDict = data["city"]! as Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast?lat=52.0&lon=13.0&APPID=1234&lang=sp&units=metric", url!);
            XCTAssertNotNil(data)
            XCTAssertNotNil(cityDict["name"]! as String)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    // MARK: Forecast
    
    func testFindCityByName() {
        let expectation = expectationWithDescription("findCityByName")
        client.findCity("Berlin") { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/find?q=Berlin&APPID=1234&lang=sp&units=metric", url!);
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testFindCityByCoordinate() {
        let expectation = expectationWithDescription("findCityByCoordinate")
        client.findCity(CLLocationCoordinate2D(latitude: 52.0, longitude: 13.0)) { result in
            let url = result.response()?.URL!.absoluteString
            let data = result.data()
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/find?lat=52.0&lon=13.0&APPID=1234&lang=sp&units=metric", url!);
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
