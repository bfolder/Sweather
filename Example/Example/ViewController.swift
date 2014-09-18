//
//  ViewController.swift
//  Example
//
//  Created by Heiko Dreyer on 08/12/14.
//  Copyright (c) 2014 boxedfolder.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet var textField: UITextField?
    @IBOutlet var textView: UITextView?
    
    var client: Sweather?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        client = Sweather(apiKey: "your_key")
        activityIndicatorView?.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if !textField.text.isEmpty {
            textView?.text = ""
            textField.resignFirstResponder()
            activityIndicatorView?.hidden = false;
            client?.currentWeather(textField.text) { result in
                self.activityIndicatorView?.hidden = true;
                switch result {
                case .Error(let response, let error):
                    self.textView?.text = "Some error occured. Try again."
                case .Success(let response, let dictionary):
                    self.textView?.text = "Received data: \(dictionary)"
                    
                    // Get temperature for city this way
                    let city = dictionary["name"] as? String;
                    let temperature = dictionary["main"]!["temp"] as Int;
                    println("City: \(city) Temperature: \(temperature)")
                }
            }
            return true
        }
        return false
    }
}

