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
    var userIsInTheMiddleOfTypingNumber = false
    
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
    
    // Enter button, execute and put number into internal stack
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    // PERFORM OPERATION THAT ONLY TAKES TWO ARGUMENTS
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // PERFORM OPERATION THAT ONLY TAKES ONE ARGUMENT
    func performOperation(operation: ( Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    // Operator action, method
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        switch operation {
            // closure for operations, and careful with order of operations
        case "×": performOperation() {$0 * $1}
        case "÷": performOperation() { $1 / $0 }
        case "−": performOperation() { $0 + $1 }
        case "+": performOperation() { $1 - $0 }
        case "√": performOperation() { sqrt($0) }
        default: break
        }
    }
    
    // INTERNAL STACK, array and initialize to an empty array
    var operandStack = Array<Double>()
    
    
    
    
    
    
    
     
    
    
}

