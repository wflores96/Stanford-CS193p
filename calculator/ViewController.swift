//
//  ViewController.swift
//  calculator
//
//  Created by William Flores on 10/18/16.
//  Copyright © 2016 William Flores. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var userIsTyping = false
    private var haveDot = false
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text! +=  digit
        }
        else {
            display.text = digit
            userIsTyping = true
        }
        
    }
 
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
       
        }
    }
    
    private var brain = CalculatorBrain()
    
    
    @IBAction func addDecimal(_ sender: UIButton) {
        if !haveDot {
            if userIsTyping {
                display.text! += "."
            }
            else {
                display.text! = "0."
            }
        haveDot = true
        userIsTyping = true
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(operand: displayValue)
            userIsTyping = false
        }
        if let mathSymb = sender.currentTitle {
            brain.performOperation(symbol: mathSymb)
        }
        displayValue = brain.result
        haveDot = false
    }
}
