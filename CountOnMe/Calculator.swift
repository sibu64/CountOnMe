//
//  Model.swift
//  CountOnMe
//
//  Created by Darrieumerlou on 20/06/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum Operator: String {
    case addition = "+"
    case soustraction = "-"
    case multiplication = "*"
    case multiplicationWithX = "x"
    case division = "/"
    case dot = "."
}

class Calculator {
    // Collection of displayed elements like numbers or operators
    public private(set) var elements = [String]()
    
    // Return the last element of elements
    private var lastElement: String? {
        return elements.last
    }
    
    // Return correct formatted expression of elements
    public var expression: String {
        return elements.joined()
    }
    
    @discardableResult
    // Add numbers or operands if possible and return true or false for interact with ui
    public func add(_ element: String) ->Bool {
        if addOperator(element) {
            element == "x" ?
                self.elements.append("*") :
                self.elements.append(element)
            return true
        }
        
        if addNumber(element) {
            self.elements.append(element)
            return true
        }
        
        return false
    }
    
    @discardableResult
    // Return the double result of expression with 2 decimals
    public func calculate() ->Double? {
        guard let lastElement = self.lastElement else { return nil }
        if isOperatorOrDot(lastElement) == true { return nil }
        
        let format = elements.joined()
        let result = NSExpression(format: format)
        guard let value = result.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double else {
            return 0.0
        }
        return value.rounded(toPlaces: 2)
    }
    
    // Reset elements
    public func clear() {
        elements.removeAll()
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    // Check if operator can be added. If yes return true.
    private func addOperator(_ value: String) ->Bool {
        if isOperatorOrDot(value) {
            if canAddOperator() {
                return true
            }
        }
        return false
    }
    
    // Check if number can be added. If yes return true.
    private func addNumber(_ value: String) ->Bool {
        if isNumber(value) {
            if canAdd(number: value) {
                return true
            }
        }
        return false
    }
    
    // Check if operator can be added. If yes return true
    private func canAddOperator() ->Bool {
        guard let lastElement = lastElement else { return false }
        let validNumber = isNumber(lastElement)
        return validNumber
    }
    
    // Check if a number can be divided. If yes return true.
    // If number is zero return false
    private func canDivideBy(number: String, with operator: String) ->Bool {
        if `operator` == "/" && number == "0" {
            return false
        }
        return true
    }
    
    // Check if can add a number.
    private func canAdd(number: String) ->Bool {
        guard let lastElement = lastElement else { return true }
        if isOperatorOrDot(lastElement) {
            return canDivideBy(number: number, with: lastElement)
        }
        if isNumber(lastElement) {
            return true
        }
        return false
    }
    
    // Check if is an operator or dot. If yes return true.
    private func isOperatorOrDot(_ value: String) ->Bool {
        guard let operand = Operator(rawValue: value) else {
            return false
        }
        switch operand {
        case .addition, .division, .multiplication, .multiplicationWithX, .soustraction, .dot:
            return true
        }
    }
    
    // Check if is a number. If yes return true.
    private func isNumber(_ value: String) ->Bool {
        guard let _ = Double(value) else { return false }
        return true
    }
}
