//
//  CheckCompatibilityViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 15/12/2024.
//

import UIKit

protocol CheckCompatibilityDelegate: AnyObject {
    func didSelectOption(_ option: String)
}

class CheckCompatibilityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CheckCompatibilityDelegate {
    func didSelectOption(_ option: String) {
        <#code#>
    }
    
    
    var model: [table] = tableData
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownTableViewCell.nib(), forCellReuseIdentifier: DropDownTableViewCell.identifier)
    }

    // MARK: - TableView Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].isExpanded ? model[section].options.count + 1 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier) as! DropDownTableViewCell
            cell.configure(with: model[indexPath.section].title)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Options", for: indexPath)
            cell.textLabel?.text = model[indexPath.section].options[indexPath.row - 1]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            model[indexPath.section].isExpanded.toggle()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else if indexPath.row == 1 {
            let selectedOption = model[indexPath.section].options[indexPath.row - 1]
            // go to default page
            performSegue(withIdentifier: "showController2", sender: selectedOption)
        } else {
            
//            go to edit custom  page
        }
    }

    // Prepare for segue to Controller 2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showController2", let destinationVC = segue.destination as? compatabilityResult, let selectedOption = sender as? String {
            // Set the delegate to CheckCompatibilityViewController
            destinationVC.delegate = self // Ensure the delegate is set to CheckCompatibilityViewController
            // Pass the selected option to Controller 2
            destinationVC.selectedOption = selectedOption
        }
    }
}
