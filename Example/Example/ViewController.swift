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
        client = Sweather(apiKey: "ea42045886608526507915df6b33b290")
        activityIndicatorView?.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            textView?.text = ""
            textField.resignFirstResponder()
            activityIndicatorView?.isHidden = false
            client?.currentWeather(textField.text!) { result in
                self.activityIndicatorView?.isHidden = true
                switch result {
                case .Error(_, let error):
                    self.textView?.text = "Some error occured. Try again."
                    print("Error: \(error)")
                case .success(_, let dictionary):
                    self.textView?.text = "Received data: \(dictionary)"
                    
                    // Get temperature for city this way
                    if let city = dictionary?["name"] as? String, let dict = dictionary?["main"] as? NSDictionary,
                        let temperature = dict["temp"] as? Int {
                            print("City: \(city) Temperature: \(temperature)")
                    }
                }
            }
            return true
        }
        return false
    }
}

