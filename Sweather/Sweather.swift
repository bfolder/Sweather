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
    public enum TemperatureFormat: String {
        case Celcius = "metric"
        case Fahrenheit = "imperial"
        case Default = ""
    }
    
    public var apiKey: String
    public var apiVersion: String
    public var language: String
    public var temperatureFormat: TemperatureFormat
    
    private var queue: NSOperationQueue;
    
    private struct Defines {
        static let basePath = "http://api.openweathermap.org/data/"
    }
    
    // MARK: --
    // MARK: Initialization
    
    public convenience init(apiKey: String) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: TemperatureFormat.Default, apiVersion: "2,5")
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
        self.queue = NSOperationQueue()
    }
    
    // MARK: --
    // MARK: Retrieving current weather data
    
    public func currentWeather(cityName: String, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/weather?q=\(cityName)", callback: callback);
    }
    
    public func currentWeather(coordinate: CLLocationCoordinate2D, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        let coordinateString = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        call("/weather?\(coordinateString)", callback: callback);
    }
    
    public func currentWeather(cityId: Int, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/weather?id=\(cityId)", callback: callback);
    }
    
    // MARK: --
    // MARK: Retrieving daily forecast
    
    public func dailyForecast(cityName: String, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/forecast/daily?q=\(cityName)", callback: callback);
    }
    
    public func dailyForecast(coordinate: CLLocationCoordinate2D, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/forecast/daily?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback);
        
    }
    
    public func dailyForecast(cityId: Int, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/forecast/daily?id=\(cityId)", callback: callback);
        
    }
    
    // MARK: --
    // MARK: Retrieving forecast
    
    public func forecast(cityName: String, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/forecast?q=\(cityName)", callback: callback);
    }
    
    public func forecast(coordinate: CLLocationCoordinate2D, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback);
    }
    
    public func forecast(cityId: Int, callback: (NSError!, NSURLResponse!, NSDictionary!) ->()) {
        call("/forecast?id=\(cityId)", callback: callback);
    }
    
    // MARK: --
    // MARK: Retrieving city 
    
    public func findCity(cityName: String, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/find?q=\(cityName)", callback: callback);
    }
    
    
    public func findCity(coordinate: CLLocationCoordinate2D, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        call("/find?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback);
    }
    
    // MARK: --
    // MARK: Call the api
    
    private func call(method: String, callback: (NSError!, NSURLResponse!, NSDictionary!) -> ()) {
        let url = Defines.basePath + apiVersion + method + "&APPID=\(apiKey)&lang=\(language)&units=\(temperatureFormat.toRaw())"
        let request = NSURLRequest(URL: NSURL(string: url))
        println(url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var anError: NSError? = error
            var dictionary: NSDictionary?
            
            if let sData = data {
               dictionary = NSJSONSerialization.JSONObjectWithData(sData, options: NSJSONReadingOptions.MutableContainers, error: &anError) as? NSDictionary;
            }
            
            callback(error, response, dictionary)
        }
    }
}