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
    var client:Sweather!
    
    override func setUp() {
        super.setUp()
        client = Sweather(apiKey: "ea42045886608526507915df6b33b290", language: "sp", temperatureFormat: .Celsius, apiVersion: "2.5")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(client.language, "sp")
        XCTAssertEqual(client.apiKey, "ea42045886608526507915df6b33b290")
        XCTAssertEqual(client.temperatureFormat, Sweather.TemperatureFormat.Celsius)
        XCTAssertEqual(client.apiVersion, "2.5")
    }
    
    // MARK: -
    // MARK: Current weather
    
    func testCurrentWeatherByName() {
        let exp = expectation(description: "currentWeatherByName")
        client.currentWeather("Berlin") { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/weather?q=Berlin&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(data!["name"] as? String, "Berlin")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCurrentWeatherById() {
        let exp = expectation(description: "currentWeatherById")
        client.currentWeather(2950159) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()!
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/weather?id=2950159&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(data["name"] as? String, "Berlin")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCurrentWeatherByCoordinate() {
        let exp = expectation(description: "currentWeatherById")
        client.currentWeather(CLLocationCoordinate2D(latitude: 52, longitude: 13)) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()!
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/weather?lat=52.0&lon=13.0&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertNotNil(data["name"] as! String)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Daily forecast
    
    func testDailyForecastByName() {
        let exp = expectation(description: "dailyForecastByName")
        client.dailyForecast("Berlin") { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()! as! Dictionary<String, AnyObject>
            let cityDict = data["city"]! as! Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast/daily?q=Berlin&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"] as? String, "Berlin")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDailyForecastById() {
        let exp = expectation(description: "dailyForecastById")
        client.dailyForecast(2950159) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()! as! Dictionary<String, AnyObject>
            let cityDict = data["city"]! as! Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast/daily?id=2950159&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"] as? String, "Berlin")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDailyForecastByCoordinate() {
        let exp = expectation(description: "dailyForecastByCoordinate")
        client.dailyForecast(CLLocationCoordinate2D(latitude: 52, longitude: 13)) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()! as! Dictionary<String, AnyObject>
            let cityDict = data["city"] as? Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast/daily?lat=52.0&lon=13.0&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertNotNil(cityDict)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Forecast
    
    func testForecastByName() {
        let exp = expectation(description: "dailyForecastByName")
        client.forecast("Berlin") { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()! as! Dictionary<String, AnyObject>
            let cityDict = data["city"]! as! Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast?q=Berlin&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"] as? String, "Berlin")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testForecastById() {
        let exp = expectation(description: "dailyForecastById")
        client.forecast(2950159) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()! as! Dictionary<String, AnyObject>
            let cityDict = data["city"]! as! Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast?id=2950159&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertEqual(cityDict["name"] as? String, "Berlin")
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testForecastByCoordinate() {
        let exp = expectation(description: "dailyForecastByCoordinate")
        client.forecast(CLLocationCoordinate2D(latitude: 52, longitude: 13)) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()! as! Dictionary<String, AnyObject>
            let cityDict = data["city"]! as! Dictionary<String,AnyObject>
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/forecast?lat=52.0&lon=13.0&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            XCTAssertNotNil(cityDict["name"] as? String)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK: Forecast
    
    func testFindCityByName() {
        let exp = expectation(description: "findCityByName")
        client.findCity("Berlin") { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/find?q=Berlin&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFindCityByCoordinate() {
        let exp = expectation(description: "findCityByCoordinate")
        client.findCity(CLLocationCoordinate2D(latitude: 52.0, longitude: 13.0)) { result in
            let url = result.response()?.url!.absoluteString
            let data = result.data()
            XCTAssertNotNil(url)
            XCTAssertEqual("http://api.openweathermap.org/data/2.5/find?lat=52.0&lon=13.0&APPID=ea42045886608526507915df6b33b290&lang=sp&units=metric", url!)
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
