//
//  3-Advanced-Standard.swift
//  TPWorkshopUnitTestTests
//
//  Created by digital.aurum on 18/11/21.
//

import XCTest
@testable import TPWorkshopUnitTest

class __Advanced: XCTestCase {
    func test_single_struct() {
        let productResult = Product(id: 1,
                                    name: "lorem ipsum",
                                    imageURL: nil,
                                    price: "Rp 10.000",
                                    shop: Shop(id: 10, name: "Toko Serba Ada", location: "Bandung"))
        let expectedResult = Product(id: 2,
                                     name: "lorem ipsum - 2",
                                     imageURL: nil,
                                     price: "Rp 10.000",
                                     shop: Shop(id: 10, name: "Toko Serba Ada", location: "Bandung"))
        
        XCTAssertNotEqual(productResult, expectedResult)
    }
    
    func test_array_struct() {
        let firstProduct = Product(id: 1,
                                    name: "lorem ipsum",
                                    imageURL: nil,
                                    price: "Rp 10.000",
                                    shop: Shop(id: 10, name: "Toko Serba Ada", location: "Bandung"))
        let secondProduct = Product(id: 2,
                                     name: "lorem ipsum - 2",
                                     imageURL: nil,
                                     price: "Rp 10.000",
                                     shop: Shop(id: 10, name: "Toko Serba Ada", location: "Bandung"))
        
        let products = [firstProduct, secondProduct]
        let expectedProducts = [secondProduct, firstProduct]
        XCTAssertNotEqual(products, expectedProducts)
    }
    
    func test_positive_didLoad() {
        let useCase = MockPositiveWorkshopProvider()
        let viewModel = ThirdViewModel(useCase: useCase)
        let expectation = expectation(description: "should return product data")
        let resultExpectation = MockProductData.generateProductResult().data
        
        viewModel.receiveData = {
            XCTAssertEqual(viewModel.products, resultExpectation)
            expectation.fulfill()
        }
        
        viewModel.didLoad()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_negative_didLoad() {
        let useCase = MockNegativeWorkshopProvider()
        let viewModel = ThirdViewModel(useCase: useCase)
        let expectation = expectation(description: "should return error")
        
        viewModel.onErrorReceiveData = { message in
            XCTAssertEqual(message, "failed")
            expectation.fulfill()
        }
        
        viewModel.didLoad()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_positive_click_sideEffect() {
        let useCase = MockPositiveWorkshopProvider()
        let viewModel = ThirdViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        let tapTriggerExpectation = expectation(description: "should return side effect")
        let resultExpectation = MockProductData.generateProductResult().data
        
        viewModel.receiveData = {
            XCTAssertEqual(viewModel.products, resultExpectation)
            loadExpectation.fulfill()
        }
        
        viewModel.doSideEffect = { message in
            XCTAssertEqual(message, "something crazy \(resultExpectation[0].name)")
            tapTriggerExpectation.fulfill()
        }
        
        viewModel.didLoad()
        wait(for: [loadExpectation], timeout: 1)
        viewModel.didSelect(index: 0)
        wait(for: [tapTriggerExpectation], timeout: 1)
    }
    
    func test_negative_click_sideEffect() {
        let useCase = MockPositiveWorkshopProvider()
        let viewModel = ThirdViewModel(useCase: useCase)
        let tapTriggerExpectation = expectation(description: "should return error side effect")
                
        viewModel.doSideEffect = { message in
            XCTAssertEqual(message, "error")
            tapTriggerExpectation.fulfill()
        }
        
        viewModel.didSelect(index: 0)
        wait(for: [tapTriggerExpectation], timeout: 1)
    }
}
