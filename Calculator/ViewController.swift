//
//  ViewController.swift
//  Calculator
//
//  Created by Shani on 4/17/15.
//  Copyright (c) 2015 Shani Rivers. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    // Properties: initialized or has value set
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        
        // Unwrapped current title
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }
}

