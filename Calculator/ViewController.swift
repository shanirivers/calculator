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
    
    // Set the historyDisplay label to empty on start up
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyDisplay.text = "0"
    }
    
    // Properties: initialized or has value set
    var userIsInTheMiddleOfTypingNumber = false
    
    // Calculator brain, model
    var  brain = CalculatorBrain()
    var tempHistory: [String] = []
    var historyPretty: [String] = []
    
    
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
            
            // append the display text to the temporary history array
            if display.text != "π" {tempHistory.append(display.text!)}

            userIsInTheMiddleOfTypingNumber = false
        }
    }


    
    // Show the history of the last 2 calculations and then clear out the temporary history array
    func showHistoryDetail() {
        if historyPretty.count > 1 {
            historyDisplay.text = "\(historyPretty.last!)\n" + "\(historyPretty[historyPretty.count - 2])"
        } else {
            historyDisplay.text = historyPretty.last!
        }
        
        tempHistory.removeAll(keepCapacity: false)
    }
    
    // Operator action, method
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                
                // Append the operation to the temporary history array
                tempHistory.append(operation)
                
                // Set the history display formatting based on the value of the operand and tack the pretty print format with values from the temporary history array to the pretty-print array
                if tempHistory.last == "√" || tempHistory.last == "sin" || tempHistory.last == "cos" {
                    historyPretty.append("\(tempHistory.last!) (\(tempHistory.first!)) = \(result)")
                    showHistoryDetail()
                }
                    
//                else if tempHistory.last == "π" {
//                    historyPretty.append("\(tempHistory.first!) (\(tempHistory.last!)) (\(tempHistory[1]))= \(result)")
//                    showHistoryDetail()
//                }
                    
                else {
                    historyPretty.append("\(tempHistory[0]) \(tempHistory.last!) \(tempHistory[1]) = \(result)")
                    showHistoryDetail()
                    
                    for calculations in historyPretty {
                        print(historyPretty)
                    }
                }
                
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
    
    // CLEAR button, to execute to clear contents from stack and all arrays
    @IBAction func clear() {
        userIsInTheMiddleOfTypingNumber = false
        brain.clearOpStack()
        tempHistory.removeAll(keepCapacity: false)
        historyPretty.removeAll(keepCapacity: false)
        historyDisplay.text = "0"
        display.text = "0"
    }
    
}

