//
//  Sweather.swift
//  Tests
//
//  Created by Heiko Dreyer on 08/12/14.
//  Copyright (c) 2014 boxedfolder.com. All rights reserved.
//

import Foundation
import CoreLocation

public class Sweather {
    public enum TemperatureFormat {
        case Kelvin, Celcius, Fahrenheit
    }
    
    public var apiKey:String
    public var apiVersion:String
    public var language: String
    public var temperatureFormat:TemperatureFormat
    
    // MARK: --
    // MARK: Initialization
    
    public convenience init(apiKey: String) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: TemperatureFormat.Fahrenheit, apiVersion: "2,5")
    }
    
    public convenience init(apiKey: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: temperatureFormat, apiVersion: "2,5")
    }
    
    public convenience init(apiKey: String, language: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: language, temperatureFormat: temperatureFormat, apiVersion: "2,5")
    }
    
    public init(apiKey: String, language: String, temperatureFormat: TemperatureFormat, apiVersion: String) {
        self.apiKey = apiKey
        self.temperatureFormat = temperatureFormat
        self.apiVersion = apiVersion
        self.language = language
    }
    
    // MARK: --
    // MARK: Retrieving current weather data
    
    public func currentWeather(cityName: String, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    public func currentWeather(coordinate: CLLocationCoordinate2D, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    public func currentWeather(cityId: Int, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    // MARK: --
    // MARK: Retrieving daily forecast
    
    public func dailyForecast(cityName: String, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    public func dailyForecast(coordinate: CLLocationCoordinate2D, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    public func dailyForecast(cityId: Int, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    // MARK: --
    // MARK: Retrieving forecast
    
    public func forecast(cityName: String, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    public func forecast(coordinate: CLLocationCoordinate2D, callback: () -> (NSError, Dictionary<String,String>)) {
        
    }
    
    public func forecast(cityId: Int, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    // MARK: --
    // MARK: Retrieving city 
    
    public func findCity(cityName: String, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    
    public func findCity(coordinate: CLLocationCoordinate2D, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
    
    // MARK: --
    // MARK: Call to api
    
    private func call(method: String, callback: () -> (NSError, Dictionary<String, String>)) {
        
    }
}