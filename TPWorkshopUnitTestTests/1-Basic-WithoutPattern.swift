//
//  1-Basic-WithoutPattern.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 18/11/21.
//

import XCTest
@testable import TPWorkshopUnitTest

class __Basic_WithoutPattern: XCTestCase {
    var vc: FirstBasicViewController!
    
    override func setUpWithError() throws {
        vc = FirstBasicViewController(nibName: "FirstBasicViewController", bundle: nil)
        vc.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        vc = nil
    }
    
    /*
     testing function odd or even
     */
    func test_isEven_odd() {
        let isOdd = vc.isEven(number: 33)
        XCTAssertFalse(isOdd, "found even number")
    }
    
    func test_isEven_even() {
        let isEven = vc.isEven(number: 50)
        XCTAssertTrue(isEven, "found odd number")
    }
    
    /*
     testing function number formatter
     */
    func test_numberFormatter_zero() {
        let numberFormatted = vc.numberFormatter(number: 0)
        XCTAssertEqual(numberFormatted, "Rp 0")
    }
    
    func test_numberFormatter_number() {
        let numberFormatted = vc.numberFormatter(number: 3)
        XCTAssertEqual(numberFormatted, "Rp 3")
    }
    
    func test_numberFormatter_tens() {
        let numberFormatted = vc.numberFormatter(number: 84)
        XCTAssertEqual(numberFormatted, "Rp 84")
    }
    
    func test_numberFormatter_tens_withZero() {
        let numberFormatted = vc.numberFormatter(number: 10)
        XCTAssertEqual(numberFormatted, "Rp 10")
    }
    
    func test_numberFormatter_hundred() {
        let numberFormatted = vc.numberFormatter(number: 639)
        XCTAssertEqual(numberFormatted, "Rp 639")
    }
    
    func test_numberFormatter_hundred_withZero() {
        let numberFormatted = vc.numberFormatter(number: 101)
        XCTAssertEqual(numberFormatted, "Rp 101")
    }
    
    func test_numberFormatter_thousand() {
        let numberFormatted = vc.numberFormatter(number: 5623)
        XCTAssertEqual(numberFormatted, "Rp 5.623")
    }
    
    func test_numberFormatter_thousand_withZero() {
        let numberFormatted = vc.numberFormatter(number: 1001)
        XCTAssertEqual(numberFormatted, "Rp 1.001")
    }
    
    func test_numberFormatter_tens_thousand() {
        let numberFormatted = vc.numberFormatter(number: 32182)
        XCTAssertEqual(numberFormatted, "Rp 32.182")
    }
    
    func test_numberFormatter_tens_thousand_withZero() {
        let numberFormatted = vc.numberFormatter(number: 10021)
        XCTAssertEqual(numberFormatted, "Rp 10.021")
    }
    
    func test_numberFormatter_hundred_thousand() {
        let numberFormatted = vc.numberFormatter(number: 932175)
        XCTAssertEqual(numberFormatted, "Rp 932.175")
    }
    
    func test_numberFormatter_hundred_thousand_withZero() {
        let numberFormatted = vc.numberFormatter(number: 100021)
        XCTAssertEqual(numberFormatted, "Rp 100.021")
    }
    
    func test_numberFormatter_million() {
        let numberFormatted = vc.numberFormatter(number: 3828232)
        XCTAssertEqual(numberFormatted, "Rp 3.828.232")
    }
    
    func test_numberFormatter_tens_million() {
        let numberFormatted = vc.numberFormatter(number: 83512390)
        XCTAssertEqual(numberFormatted, "Rp 83.512.390")
    }
    
    func test_numberFormatter_hundred_million() {
        let numberFormatted = vc.numberFormatter(number: 128312852)
        XCTAssertEqual(numberFormatted, "Rp 128.312.852")
    }
    
    func test_numberFormatter_billion() {
        let numberFormatted = vc.numberFormatter(number: 9238912932)
        XCTAssertEqual(numberFormatted, "Rp 9.238.912.932")
    }
    
    func test_numberFormatter_currency() {
        let numberFormatter = vc.numberFormatter(number: 1000, currency: "$")
        XCTAssertEqual(numberFormatter, "$ 1.000")
    }
    
    func test_numberFormatter_separator() {
        let numberFormatter = vc.numberFormatter(number: 1000, separator: ",", currency: "SGD")
        XCTAssertEqual(numberFormatter, "SGD 1,000")
    }
}
