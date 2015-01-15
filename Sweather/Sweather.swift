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
    }
    
    public enum Result {
        case Success(NSURLResponse!, NSDictionary!)
        case Error(NSURLResponse!, NSError!)
        
        public func data() -> NSDictionary? {
            switch self {
            case .Success(let response, let dictionary):
                return dictionary
            case .Error(let response, let error):
                return nil
            }
        }
        
        public func response() -> NSURLResponse? {
            switch self {
            case .Success(let response, let dictionary):
                return response
            case .Error(let response, let error):
                return response
            }
        }
        
        public func error() -> NSError? {
            switch self {
            case .Success(let response, let dictionary):
                return nil
            case .Error(let response, let error):
                return error
            }
        }
    }
    
    public var apiKey: String
    public var apiVersion: String
    public var language: String
    public var temperatureFormat: TemperatureFormat
    
    private var queue: NSOperationQueue;
    
    private struct Const {
        static let basePath = "http://api.openweathermap.org/data/"
    }
    
    // MARK: -
    // MARK: Initialization
    
    public convenience init(apiKey: String) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: .Fahrenheit, apiVersion: "2.5")
    }
    
    public convenience init(apiKey: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: temperatureFormat, apiVersion: "2.5")
    }
    
    public convenience init(apiKey: String, language: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: language, temperatureFormat: temperatureFormat, apiVersion: "2.5")
    }
    
    public init(apiKey: String, language: String, temperatureFormat: TemperatureFormat, apiVersion: String) {
        self.apiKey = apiKey
        self.temperatureFormat = temperatureFormat
        self.apiVersion = apiVersion
        self.language = language
        self.queue = NSOperationQueue()
    }
    
    // MARK: -
    // MARK: Retrieving current weather data
    
    public func currentWeather(cityName: String, callback: (Result) -> ()) {
        call("/weather?q=\(cityName)", callback: callback);
    }
    
    public func currentWeather(coordinate: CLLocationCoordinate2D, callback: (Result) -> ()) {
        let coordinateString = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        call("/weather?\(coordinateString)", callback: callback);
    }
    
    public func currentWeather(cityId: Int, callback: (Result) -> ()) {
        call("/weather?id=\(cityId)", callback: callback);
    }
    
    // MARK: -
    // MARK: Retrieving daily forecast
    
    public func dailyForecast(cityName: String, callback: (Result) -> ()) {
        call("/forecast/daily?q=\(cityName)", callback: callback);
    }
    
    public func dailyForecast(coordinate: CLLocationCoordinate2D, callback: (Result) -> ()) {
        call("/forecast/daily?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback);
        
    }
    
    public func dailyForecast(cityId: Int, callback: (Result) -> ()) {
        call("/forecast/daily?id=\(cityId)", callback: callback);
    }
    
    // MARK: -
    // MARK: Retrieving forecast
    
    public func forecast(cityName: String, callback: (Result) -> ()) {
        call("/forecast?q=\(cityName)", callback: callback);
    }
    
    public func forecast(coordinate: CLLocationCoordinate2D, callback:(Result) -> ()) {
        call("/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback);
    }
    
    public func forecast(cityId: Int, callback: (Result) ->()) {
        call("/forecast?id=\(cityId)", callback: callback);
    }

    // MARK: -
    // MARK: Retrieving city 
    
    public func findCity(cityName: String, callback: (Result) -> ()) {
        call("/find?q=\(cityName)", callback: callback);
    }
    
    
    public func findCity(coordinate: CLLocationCoordinate2D, callback: (Result) -> ()) {
        call("/find?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback);
    }
    
    // MARK: -
    // MARK: Call the api
    
    private func call(method: String, callback: (Result) -> ()) {
        let url = Const.basePath + apiVersion + method + "&APPID=\(apiKey)&lang=\(language)&units=\(temperatureFormat.rawValue)"
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let currentQueue = NSOperationQueue.currentQueue();
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response: NSURLResponse!, data: NSData!, error: NSError?) -> Void in
            var error: NSError? = error
            var dictionary: NSDictionary?
            
            if let data = data {
               dictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &error) as? NSDictionary;
            }
            currentQueue?.addOperationWithBlock {
                var result = Result.Success(response, dictionary)
                if error != nil {
                    result = Result.Error(response, error)
                }
                callback(result)
            }
        }
    }
}