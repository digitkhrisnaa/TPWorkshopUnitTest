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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Basic"
        numberFormatterTextField.delegate = self
    }
    
    @IBAction func didTapFindOddEven(_ sender: Any) {
        
    }
}

extension SecondBasicViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
}
