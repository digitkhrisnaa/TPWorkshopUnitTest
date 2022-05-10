//
//  2-Basic-WithPattern.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 18/11/21.
//

import XCTest
@testable import TPWorkshopUnitTest

class __Basic_WithPattern: XCTestCase {

    var viewModel: SecondBasicViewModel!
    override func setUp() {
        viewModel = SecondBasicViewModel()
    }
    
    /*
        testing function odd or even
     */
    func test_isEven_notNumber() {
        let expect = expectation(description: "check if isEven function is not number")
        viewModel.resultOddEven = { result in
            XCTAssertEqual(result, "Please put number")
            expect.fulfill()
        }
        
        viewModel.isEven(text: "asdf")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_isEven_odd() {
        let expect = expectation(description: "check if isEven returning Ganjil")
        viewModel.resultOddEven = { result in
            XCTAssertEqual(result, "Ganjil")
            expect.fulfill()
        }
        
        viewModel.isEven(text: "33")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_isEven_even() {
        let expect = expectation(description: "check if isEven returning Genap")
        viewModel.resultOddEven = { result in
            XCTAssertEqual(result, "Genap")
            expect.fulfill()
        }
        
        viewModel.isEven(text: "32")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /*
        testing function number formatter
     */
    
    func text_numberFormatter_notNumber() {
        let expect = expectation(description: "number formatter not number")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Please put number")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "asdf")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_zero() {
        let expect = expectation(description: "number formatter return zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 0")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "0")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_number() {
        let expect = expectation(description: "number formatter return number")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 3")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "3")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_tens() {
        let expect = expectation(description: "number formatter return tens")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 84")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "84")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_tens_withZero() {
        let expect = expectation(description: "number formatter return tens with zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 10")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "10")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_hundred() {
        let expect = expectation(description: "number formatter return hundred")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 639")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "639")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_hundred_withZero() {
        let expect = expectation(description: "number formatter return hundred with zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 101")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "101")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_thousand() {
        let expect = expectation(description: "number formatter return thousand")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 5.623")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "5623")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_thousand_withZero() {
        let expect = expectation(description: "number formatter return thousand with zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 1.001")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "1001")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_tens_thousand() {
        let expect = expectation(description: "number formatter return tens thousand")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 32.182")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "32182")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_tens_thousand_withZero() {
        let expect = expectation(description: "number formatter return tens thousand with zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 10.021")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "10021")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_hundred_thousand() {
        let expect = expectation(description: "number formatter return hundred thousand")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 932.175")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "932175")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_hundred_thousand_withZero() {
        let expect = expectation(description: "number formatter return hundred thousand with zero")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 100.021")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "100021")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_million() {
        let expect = expectation(description: "number formatter return million")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 3.828.232")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "3828232")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_tens_million() {
        let expect = expectation(description: "number formatter return tens million")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 83.512.390")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "83512390")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_hundred_million() {
        let expect = expectation(description: "number formatter return hundred million")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 128.312.852")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "128312852")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_billion() {
        let expect = expectation(description: "number formatter return billion")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "Rp 9.238.912.932")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "9238912932")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_currency() {
        let expect = expectation(description: "number formatter return currency")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "$ 1.000")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "1000", currency: "$")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_numberFormatter_separator() {
        let expect = expectation(description: "number formatter return separator")
        viewModel.resultNumberFormatter = { result in
            XCTAssertEqual(result, "SGD 1,000")
            expect.fulfill()
        }
        
        viewModel.numberFormatter(text: "1000", separator: ",", currency: "SGD")
        waitForExpectations(timeout: 1, handler: nil)
    }
}