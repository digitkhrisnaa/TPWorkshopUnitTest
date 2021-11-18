//
//  FirstBasicViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 18/11/21.
//

import UIKit

class FirstBasicViewController: UIViewController {

    @IBOutlet weak var oddEvenTextField: UITextField!
    @IBOutlet weak var oddEvenButton: UIButton!
    @IBOutlet weak var oddEvenResultLabel: UILabel!
    @IBOutlet weak var numberFormatterTextField: UITextField!
    @IBOutlet weak var numberFormatterResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First Basic"
        
        numberFormatterTextField.delegate = self
    }

    @IBAction func didTapFindOddEven(_ sender: Any) {
        guard let oddEvenText = oddEvenTextField.text, !oddEvenText.isEmpty, let number = Int(oddEvenText) else {
            oddEvenResultLabel.text = "Not number"
            return
        }
        
        if isEven(number: number) {
            oddEvenResultLabel.text = "Genap"
        } else {
            oddEvenResultLabel.text = "Ganjil"
        }
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
        guard number > 0 else {
            return "\(currency) \(number)"
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
        
        return "\(currency) \(result.joined())"
    }
}

extension FirstBasicViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let numberFormatterText = textField.text, !numberFormatterText.isEmpty, let number = Int(numberFormatterText) else {
            numberFormatterResultLabel.text = "Not number"
            return
        }
        
        numberFormatterResultLabel.text = numberFormatter(number: number)
    }
}
