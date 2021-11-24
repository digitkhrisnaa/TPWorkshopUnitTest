//
//  ForthViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit

class IntermediateViewController: UIViewController {

    let viewModel: IntermediateViewModel
    
    init() {
        self.viewModel = IntermediateViewModel(useCase: IntermediateUseCase())
        super.init(nibName: "IntermediateViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Intermediate Unit Test"
        // Do any additional setup after loading the view.
        viewModel.onDidLoad()
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
