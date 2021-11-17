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
    
    func numberFormatter(number: Int, separator: String = ".", currency: String = "Rp") -> String {
        // looping dari belakang, per tiga karakter kasih titik
        // 345 -> 543
        let arrayNumbers = String(number).map { String($0) }
        var count = 0
        var result: [String] = []
        for index in stride(from: arrayNumbers.count, to: 0, by: -1) {
            count += 1
            result.insert(arrayNumbers[index - 1], at: 0)
            if count == 3 && index != 1 {
                result.insert(separator, at: 0)
                count = 0
            }
        }
        
        return "\(currency) \(result.joined())"
    }
}

