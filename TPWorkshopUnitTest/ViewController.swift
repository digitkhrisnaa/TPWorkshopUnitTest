//
//  ViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 17/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func isEven(number: Int) -> Bool {
        if number % 2 == 0 {
            return true
        } else {
            return false
        }
    }
    
    /*
     Time complexity: O(log n)
     */
    func numberFormatter(number: Int, separator: String = ".", currency: String = "Rp") -> String {
        var copyNumber = number
        var result: [String] = []
        while copyNumber > 0 {
            let lastNumber = copyNumber % 1000
            copyNumber = copyNumber / 1000
            
            if lastNumber == 0 {
                result.insert("000", at: 0)
            } else if lastNumber < 10 && copyNumber > 0 {
                result.insert("00\(lastNumber)", at: 0)
            } else if lastNumber < 100 && copyNumber > 0 {
                result.insert("0\(lastNumber)", at: 0)
            } else {
                result.insert("\(lastNumber)", at: 0)
            }
            
            if copyNumber > 0 {
                result.insert(separator, at: 0)
            }
        }
        
        return "\(currency) \(result.joined())"
    }
}

