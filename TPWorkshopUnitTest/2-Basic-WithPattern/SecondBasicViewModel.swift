//
//  FirstBasicViewModel.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 18/11/21.
//

import Foundation

struct SecondBasicViewModel {
    // MARK: Output
    var resultOddEven: ((String) -> Void)?
    var resultNumberFormatter: ((String) -> Void)?
    
    // MARK: Input
    func isEven(text: String?) {
        guard let numberString = text, !numberString.isEmpty, let number = Int(numberString) else {
            resultOddEven?("Please put number")
            return
        }
        
        if number % 2 == 0 {
            resultOddEven?("Genap")
        } else {
            resultOddEven?("Ganjil")
        }
    }
    
    func numberFormatter(text: String?, separator: String = ".", currency: String = "Rp") {
        guard let numberString = text, !numberString.isEmpty, let number = Int(numberString) else {
            resultNumberFormatter?("Please put number")
            return
        }
        
        guard number > 0 else {
            resultNumberFormatter?("\(currency) \(number)")
            return
        }
        
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
        
        resultNumberFormatter?("\(currency) \(result.joined())")
    }
}
