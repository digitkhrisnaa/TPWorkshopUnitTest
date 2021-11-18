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
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
