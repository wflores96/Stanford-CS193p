//
//  calculatorBrain.swift
//  calculator
//
//  Created by William Flores on 10/26/16.
//  Copyright © 2016 William Flores. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private struct PendingBinaryOp {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOp?
    
    func setOperand(operand : Double) {
        accumulator = operand
    }
    
    private func clearCalc() {
        pending = nil
        accumulator = 0
        
    }
    
    private var operations: Dictionary<String,OperationType> = [
        "π" : OperationType.Constant(M_PI),  // M_PI
        "e" : OperationType.Constant(M_E),  // M_E
        "×" : OperationType.BinaryOperation({ $0 * $1 }),
        "÷" : OperationType.BinaryOperation({ $0 / $1 }),
        "+" : OperationType.BinaryOperation({ $0 + $1 }),
        "−" : OperationType.BinaryOperation({ $0 - $1 }),
        "√" : OperationType.UnaryOperation(sqrt),  // sqrt
        "C" : OperationType.Clear,  // cos
        "±" : OperationType.UnaryOperation({ -$0 }),
        "=" : .Equals
    ]
    
    private enum OperationType {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
        
    }
    
    private func execPendingBinary() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    func performOperation(symbol: String) {
        if let currOp = operations[symbol] {
            switch currOp {
            case .Constant(let associatedVal):
                accumulator = associatedVal
            case .UnaryOperation(let foo):
                accumulator = foo(accumulator)
            case .BinaryOperation(let foo):
                execPendingBinary()
                pending = PendingBinaryOp(binaryFunction: foo, firstOperand: accumulator)
            case .Equals:
                execPendingBinary()
            case .Clear:
                clearCalc()
            }
        }
        
        
    
        
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
