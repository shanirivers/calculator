//
//  ViewController.swift
//  Calculator
//
//  Created by Shani on 4/17/15.
//  Copyright (c) 2015 Shani Rivers. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!
    
    // Properties: initialized or has value set
    var userIsInTheMiddleOfTypingNumber = false
    
    // Calculator brain, model
    var  brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton) {
        // Unwrapped current title
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber {
            if digit == "." {
                if display.text!.rangeOfString(".") == nil {
                    display.text =  display.text! + digit
                }
            }
            else {
                display.text = display.text! + digit
            }
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    // Convert a string to a double, get and set it
    var displayValue: Double {
        get {
            //convert string to double with number formatter
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            // compute value
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    
    // Operator action, method
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0 // will need to set to nil for hmwk
            }
            
        }
    }
    
    // ENTER button, execute and put number into internal stack
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0 // will need to set to nil for hmwk
        }
        
    }
    
    // CLEAR button, to execute to clear contents from stack
    @IBAction func clear() {
        userIsInTheMiddleOfTypingNumber = false
        brain.clearOpStack()
        display.text = "0"
    }
}

