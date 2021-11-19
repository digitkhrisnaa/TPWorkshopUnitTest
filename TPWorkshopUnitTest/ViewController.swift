//
//  ViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 17/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let pages = [
        "1-Basic",
        "2-Basic MVVM",
        "3-Advance",
        "4-Intermediate"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = pages[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = FirstBasicViewController(nibName: "FirstBasicViewController", bundle: nil)
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = SecondBasicViewController(nibName: "SecondBasicViewController", bundle: nil)
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = ThirdViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = ForthViewController(nibName: "ForthViewController", bundle: nil)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}

