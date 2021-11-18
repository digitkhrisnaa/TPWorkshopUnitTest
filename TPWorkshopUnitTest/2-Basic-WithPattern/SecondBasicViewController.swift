//
//  SecondBasicViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 18/11/21.
//

import UIKit

class SecondBasicViewController: UIViewController {

    @IBOutlet weak var oddEvenTextField: UITextField!
    @IBOutlet weak var oddEvenButton: UIButton!
    @IBOutlet weak var oddEvenResultLabel: UILabel!
    @IBOutlet weak var numberFormatterTextField: UITextField!
    @IBOutlet weak var numberFormatterResultLabel: UILabel!
    
    var viewModel = SecondBasicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Basic"
        numberFormatterTextField.delegate = self
        
        viewModel.resultOddEven = { [weak self] result in
            self?.oddEvenResultLabel.text = result
        }
        
        viewModel.resultNumberFormatter = { [weak self] result in
            self?.numberFormatterResultLabel.text = result
        }
    }
    
    @IBAction func didTapFindOddEven(_ sender: Any) {
        viewModel.isEven(text: oddEvenTextField.text)
    }
}

extension SecondBasicViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.numberFormatter(text: textField.text)
    }
}
