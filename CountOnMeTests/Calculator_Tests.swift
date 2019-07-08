//
//  Calculator_Tests.swift
//  CountOnMeTests
//
//  Created by Darrieumerlou on 26/06/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class Calculator_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_first_action_is_an_operator() {
        let model = Calculator()
        let isValid = model.add("*")
        
        XCTAssertEqual(isValid, false)
        XCTAssertEqual(model.elements.count, 0)
    }
    
    func test_first_action_is_an_number() {
        let model = Calculator()
        let isValid = model.add("10.0")
        
        XCTAssertEqual(isValid, true)
        XCTAssertEqual(model.elements.count, 1)
        XCTAssertEqual(model.elements.first, "10.0")
    }
    
    func test_add_two_numbers() {
        let model = Calculator()
        model.add("1")
        model.add("0")
        
        XCTAssertEqual(model.elements.count, 2)
        XCTAssertEqual(model.elements.first, "1")
        XCTAssertEqual(model.elements.last, "0")
    }
    
    func test_add_10_twice() {
        let model = Calculator()
        model.add("1")
        model.add("0")
        model.add("+")
        model.add("1")
        model.add("0")
        
        XCTAssertEqual(model.elements.count, 5)
        XCTAssertEqual(model.elements.first, "1")
        XCTAssertEqual(model.elements[2], "+")
        XCTAssertEqual(model.elements.last, "0")
    }
    
    func test_add_operator_after_number() {
        let model = Calculator()
        model.add("10.0")
        let isValid = model.add("*")
        
        XCTAssertEqual(isValid, true)
        XCTAssertEqual(model.elements.count, 2)
        XCTAssertEqual(model.elements.first, "10.0")
        XCTAssertEqual(model.elements.last, "*")
    }

    func test_10_multiply_10_equal_100() {
        let model = Calculator()
        model.add("10.0")
        model.add("*")
        model.add("10.0")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 100.0)
    }
    
    func test_10_multiply_20_equal_200() {
        let model = Calculator()
        model.add("10.0")
        model.add("*")
        model.add("20.0")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 200.0)
    }
    
    func test_add_operator_multiplicaton() {
        let model = Calculator()
        model.add("1")
        model.add("x")
        
        XCTAssertEqual(model.elements.count, 2)
        XCTAssertEqual(model.elements.last, "*")
    }
    
    func test_display_number_1() {
        let model = Calculator()
        model.add("1")
        
        XCTAssertEqual(model.expression, "1")
    }
    
    func test_display_number_10() {
        let model = Calculator()
        model.add("1")
        model.add("0")
        
        XCTAssertEqual(model.expression, "10")
    }
    
    func test_display_10_add_10() {
        let model = Calculator()
        model.add("1")
        model.add("0")
        model.add("+")
        model.add("1")
        model.add("0")
        
        XCTAssertEqual(model.expression, "10+10")
    }
    
    func test_clear() {
        let model = Calculator()
        model.add("1")
        model.add("+")
        model.add("1")
        
        XCTAssertEqual(model.elements.count, 3)
        
        model.clear()
        
        XCTAssertEqual(model.elements.count, 0)
        XCTAssertEqual(model.expression, "")
    }
    
    func test_division_is_ok() {
        let model = Calculator()
        model.add("4")
        model.add("/")
        model.add("2")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 2.0)
        XCTAssertEqual(model.elements.count, 3)
    }
    
    func test_division_by_zero_is_impossible() {
        let model = Calculator()
        model.add("4")
        model.add("/")
        model.add("0")
        
        XCTAssertEqual(model.elements.count, 2)
    }
    
    func test_calculate_invalid_expression() {
        let model = Calculator()
        model.add("1")
        model.add("/")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, nil)
    }
    
    func test_operation_1() {
        let model = Calculator()
        model.add("1")
        model.add("0")
        model.add("+")
        model.add("1")
        model.add("0")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 20)
    }
    
    func test_operation_2() {
        let model = Calculator()
        model.add("2")
        model.add("0")
        model.add("-")
        model.add("1")
        model.add("0")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 10)
    }
    
    func test_operation_3() {
        let model = Calculator()
        model.add("1")
        model.add("0")
        model.add("x")
        model.add("1")
        model.add("0")
        model.add("+")
        model.add("1")
        model.add("0")
        model.add("4")
        model.add("/")
        model.add("2")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 152)
    }
    
    func test_operation_4() {
        let model = Calculator()
        model.add("5")
        model.add(".")
        model.add("2")
        model.add("/")
        model.add("3")
        
        let result = model.calculate()
        XCTAssertEqual(result, 1.73)
    }
    
    func test_result_decimal_number() {
        let model = Calculator()
        model.add("1")
        model.add("2")
        model.add("/")
        model.add("7")
        
        let result = model.calculate()
        
        XCTAssertEqual(result, 1.71)
    }
    
    func test_add_dot_is_not_the_first() {
        let model = Calculator()
        model.add(".")
        
        XCTAssertEqual(model.elements.count, 0)
    }
    
    func test_add_decimal_number() {
        let model = Calculator()
        model.add("1")
        model.add(".")
        model.add("5")
        
        XCTAssertEqual(model.elements.count, 3)
        XCTAssertEqual(model.elements.first, "1")
        XCTAssertEqual(model.elements[1], ".")
        XCTAssertEqual(model.elements.last, "5")
    }
}
