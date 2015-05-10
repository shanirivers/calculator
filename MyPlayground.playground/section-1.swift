// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var myString = "finding the. period"

myString.rangeOfString(".") != nil ?println("Exists!") : println()


//if digit == "." {
//    if display.text!.rangeOfString(".") == nil {
//        display.text =  display.text! + digit
//    }
//}
//else {
//    display.text = display.text! + digit
//}
//
//
//digit == "." ? isplay.text!.rangeOfString(".") == nil ? display.text =  display.text! + digit : : display.text = display.text! + digit


// the array will have to look at the opstack and also see the evaluate result... this array should probably exist in the brain model
var history = [5.0, 6.0, "x", 30.0]

history.count


println("\(history[0]) \(history[2]) \(history[1]) = \(history[3])")
