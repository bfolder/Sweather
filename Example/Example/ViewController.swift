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
            client?.dailyForecast(textField.text) { (error, response, dictionary) -> () in
                self.activityIndicatorView?.hidden = true;
                if let sError = error {
                    self.textView?.text = "Some error occured. Try again."
                } else {
                    if let sDictionary = dictionary {
                        self.textView?.text = "Received data: \(sDictionary)"
                    }
                }
            }
            return true
        }
        
        return false
    }
}

