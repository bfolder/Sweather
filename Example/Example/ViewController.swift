//
//  ViewController.swift
//  Example
//
//  Created by Heiko Dreyer on 12.08.14.
//  Copyright (c) 2014 boxedfolder.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet var textField: UITextField?
    
    var client: Sweather?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        client = Sweather(apiKey: "xxx")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

