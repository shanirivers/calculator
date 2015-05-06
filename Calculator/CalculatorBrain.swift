//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Shani on 4/29/15.
//  Copyright (c) 2015 Shani Rivers. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op: Printable  //Printable = a protocol, this enum implements one protocol description, this can be used for classes as well
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        // Computed property, that converts a double to a string that's read-only, could use this for the history part of the hmwk
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):  // "_" is used because don't care about function
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
            
            //no set, it's read-only
        }
    }
    
    private var opStack = [Op]() //declaring array
    private var knownOps = [String: Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        knownOps["×"] = Op.BinaryOperation("×", *)   //<-- knownOps["×"] = Op.BinaryOperation("×") { $0 * $1}
        knownOps["-"] = Op.BinaryOperation("-") { $1 - $0 } // <-- can't do it with minus or divid, due to order of operations
        knownOps["÷"] = Op.BinaryOperation("÷") { $0 / $1 }
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
        knownOps["cos()"] = Op.UnaryOperation("cos()") { cos($0) }
        knownOps["sin()"] = Op.UnaryOperation("sin()") { sin($0) }
        //        NEED TO ADD THESE TO THE MODEL, CALCULATOR BRAIN:
        //        case "π": performOperand(M_PI)
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops  // it's mutated and really no copying is occurring
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                   return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            } // no break needed, because every case has been handled
        }
        // failure, needs to return nil
        return (nil, ops)
    }
    
    // get the result
    func evaluate () -> Double? {
        let (result, remainder) = evaluate(opStack) // remainingOps = remainder, therefore the name doesn't need to be the same, as long as you return a tuple
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            // ^ always returns an optional when looking for info in a dict
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func clearOpStack () {
        opStack.removeAll(keepCapacity: false)
        println("\(opStack)")
    }
}