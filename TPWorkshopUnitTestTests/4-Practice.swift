//
//  4-Intermediate.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 24/11/21.
//

import XCTest
@testable import TPWorkshopUnitTest

class __Practice: XCTestCase {    
    internal func assertArrayHashDiffable(expectedResult: [HashDiffable], values: [HashDiffable]) {
        XCTAssertEqual(expectedResult.count, values.count, "An array count mismatch.")
        if expectedResult.count == values.count {
            expectedResult.enumerated().forEach { index, element in
                XCTAssertTrue(element.isEqual(to: values[index]), "expected index \(index) equal to \(type(of: values[index])) but get \(type(of: element)) instead")
            }
        }
    }
}

