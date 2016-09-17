//
//  Sweather.swift
//
//  Created by Heiko Dreyer on 08/12/14.
//  Copyright (c) 2014 boxedfolder.com. All rights reserved.
//

import Foundation
import CoreLocation

extension String {
    func replace(_ string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string,
            with: replacement,
            options: NSString.CompareOptions.literal,
            range: nil)
    }
    
    func replaceWhitespace() -> String {
        return self.replace(" ", replacement: "+")
    }
}

open class Sweather {
    public enum TemperatureFormat: String {
        case Celsius = "metric"
        case Fahrenheit = "imperial"
    }
    
    public enum Result {
        case success(URLResponse?, NSDictionary?)
        case Error(URLResponse?, NSError?)
        
        public func data() -> NSDictionary? {
            switch self {
            case .success(_, let dictionary):
                return dictionary
            case .Error(_, _):
                return nil
            }
        }
        
        public func response() -> URLResponse? {
            switch self {
            case .success(let response, _):
                return response
            case .Error(let response, _):
                return response
            }
        }
        
        public func error() -> NSError? {
            switch self {
            case .success(_, _):
                return nil
            case .Error(_, let error):
                return error
            }
        }
    }
    
    open var apiKey: String
    open var apiVersion: String
    open var language: String
    open var temperatureFormat: TemperatureFormat
    
    fileprivate struct Const {
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
    }
    
    // MARK: -
    // MARK: Retrieving current weather data
    
    open func currentWeather(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/weather?q=\(cityName.replaceWhitespace())", callback: callback)
    }
    
    open func currentWeather(_ coordinate: CLLocationCoordinate2D, callback: @escaping (Result) -> ()) {
        let coordinateString = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        call("/weather?\(coordinateString)", callback: callback)
    }
    
    open func currentWeather(_ cityId: Int, callback: @escaping (Result) -> ()) {
        call("/weather?id=\(cityId)", callback: callback)
    }
    
    // MARK: -
    // MARK: Retrieving daily forecast
    
    open func dailyForecast(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/forecast/daily?q=\(cityName.replaceWhitespace())", callback: callback)
    }
    
    open func dailyForecast(_ coordinate: CLLocationCoordinate2D, callback: @escaping (Result) -> ()) {
        call("/forecast/daily?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback)
        
    }
    
    open func dailyForecast(_ cityId: Int, callback: @escaping (Result) -> ()) {
        call("/forecast/daily?id=\(cityId)", callback: callback)
    }
    
    // MARK: -
    // MARK: Retrieving forecast
    
    open func forecast(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/forecast?q=\(cityName.replaceWhitespace())", callback: callback)
    }
    
    open func forecast(_ coordinate: CLLocationCoordinate2D, callback:@escaping (Result) -> ()) {
        call("/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback)
    }
    
    open func forecast(_ cityId: Int, callback: @escaping (Result) ->()) {
        call("/forecast?id=\(cityId)", callback: callback)
    }

    // MARK: -
    // MARK: Retrieving city 
    
    open func findCity(_ cityName: String, callback: @escaping (Result) -> ()) {
        call("/find?q=\(cityName.replaceWhitespace())", callback: callback)
    }
    
    open func findCity(_ coordinate: CLLocationCoordinate2D, callback: @escaping (Result) -> ()) {
        call("/find?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback)
    }
    
    // MARK: -
    // MARK: Call the api
    
    fileprivate func call(_ method: String, callback: @escaping (Result) -> ()) {
        let url = Const.basePath + apiVersion + method + "&APPID=\(apiKey)&lang=\(language)&units=\(temperatureFormat.rawValue)"
        let request = URLRequest(url: URL(string: url)!)
        let currentQueue = OperationQueue.current
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            var error: NSError? = error as NSError?
            var dictionary: NSDictionary?
            
            if let data = data {
                do {
                    dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                } catch let e as NSError {
                    error = e
                }
            }
            currentQueue?.addOperation {
                var result = Result.success(response, dictionary)
                if error != nil {
                    result = Result.Error(response, error)
                }
                callback(result)
            }
        })
        task.resume()
    }
}
