//
//  4-Intermediate.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 24/11/21.
//

import XCTest
@testable import TPWorkshopUnitTest

class __Intermediate: XCTestCase {

    func test_positive_onDidLoad() {
        let useCase = Mock4PositiveWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let expectation = expectation(description: "should return complete data")
        viewModel.didReceiveData = {
            self.assertArrayHashDiffable(expectedResult: viewModel.data,
                                    values: Mock4ProductData.generateExpectedCompleteValue())
            expectation.fulfill()
        }
        
        viewModel.onDidLoad()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_negative_failedProduct() {
        let useCase = Mock4NegativeProductWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let expectation = expectation(description: "should return error with 1 message")
        viewModel.didGotError = { messsages in
            XCTAssertEqual(messsages.count, 1)
            expectation.fulfill()
        }
        
        viewModel.onDidLoad()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_negative_failedAll() {
        let useCase = Mock4NegativeAllWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let expectation = expectation(description: "should return error with 3 messages")
        viewModel.didGotError = { messsages in
            XCTAssertEqual(messsages.count, 3)
            expectation.fulfill()
        }
        
        viewModel.onDidLoad()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_has_ticker() {
        let useCase = Mock4PositiveWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let resultExpectation = expectation(description: "should return complete data")
        let tickerExpectation = expectation(description: "should has ticker")
        viewModel.didReceiveData = {
            self.assertArrayHashDiffable(expectedResult: viewModel.data,
                                    values: Mock4ProductData.generateExpectedCompleteValue())
            resultExpectation.fulfill()
        }
        
        viewModel.hasTicker = { hasTicker in
            XCTAssertTrue(hasTicker)
            tickerExpectation.fulfill()
        }
        
        viewModel.onDidLoad()
        wait(for: [resultExpectation, tickerExpectation], timeout: 1)
    }
    
    func test_no_ticker() {
        let useCase = Mock4NegativeTickerWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let resultExpectation = expectation(description: "should return complete data")
        let tickerExpectation = expectation(description: "should return no ticker")
        viewModel.didReceiveData = {
            self.assertArrayHashDiffable(expectedResult: viewModel.data,
                                    values: Mock4ProductData.generateExpectedCompleteValue())
            resultExpectation.fulfill()
        }
        
        viewModel.hasTicker = { hasTicker in
            XCTAssertFalse(hasTicker)
            tickerExpectation.fulfill()
        }
        
        viewModel.onDidLoad()
        wait(for: [resultExpectation, tickerExpectation], timeout: 1)
    }
    
    func test_no_inspiration() {
        let useCase = Mock4NegativeInspirationWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let expectation = expectation(description: "should return complete data without inspiration")
        viewModel.didReceiveData = {
            self.assertArrayHashDiffable(expectedResult: viewModel.data,
                                    values: Mock4ProductData.generateExpectedWithoutInspirationValue())
            expectation.fulfill()
        }
        
        viewModel.onDidLoad()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fireDate() {
        var tickerMockData: Ticker?
        
        let useCase = Mock4PositiveWorkshopProvider()
        let viewModel = IntermediateViewModel(useCase: useCase)
        let firstExpectation = expectation(description: "should return complete data without ticker")
        let secondExpectation = expectation(description: "should return complete data with ticker")
        
        IntermediateEnvironment.saveTickerCache = { _, _ in
            tickerMockData = Mock4ProductData.generateTicker()
        }
        
        IntermediateEnvironment.loadTickerCache = { _ in
            tickerMockData
        }
        
        viewModel.didReceiveData = {
            self.assertArrayHashDiffable(expectedResult: viewModel.data,
                                    values: Mock4ProductData.generateExpectedCompleteValue())
            firstExpectation.fulfill()
        }
        
        viewModel.onDidLoad()
        wait(for: [firstExpectation], timeout: 1)
        
        viewModel.didReceiveData = {
            self.assertArrayHashDiffable(expectedResult: viewModel.data,
                                    values: Mock4ProductData.generateExpectedCompleteValueWithTicker())
            secondExpectation.fulfill()
        }
        
        viewModel.onFireDate()
        wait(for: [secondExpectation], timeout: 1)
    }
    
    internal func assertArrayHashDiffable(expectedResult: [HashDiffable], values: [HashDiffable]) {
        XCTAssertEqual(expectedResult.count, values.count, "An array count mismatch.")
        if expectedResult.count == values.count {
            expectedResult.enumerated().forEach { index, element in
                XCTAssertTrue(element.isEqual(to: values[index]), "expected index \(index) equal to \(type(of: values[index])) but get \(type(of: element)) instead")
            }
        }
    }
}

