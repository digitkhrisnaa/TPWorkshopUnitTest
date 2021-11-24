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
}
