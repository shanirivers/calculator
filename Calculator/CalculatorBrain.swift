//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Shani on 4/29/15.
//  Copyright (c) 2015 Shani Rivers. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
        case operand(Double)
        case unaryOperation(String, Double -> Double)
        case binaryOperation(String, (Double, Double) -> Double)
    }
    var ops = [Op]() //declaring array
    
}