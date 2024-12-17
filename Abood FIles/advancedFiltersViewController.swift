//
//  advancedFiltersViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 13/12/2024.
//

import UIKit

class advancedFiltersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "dropdownCell", bundle: nil)
            table.register(nib, forCellReuseIdentifier: "dropdownCell")
        let salaryNib = UINib(nibName: "SalaryCell", bundle: nil)
           table.register(salaryNib, forCellReuseIdentifier: "SalaryCell")
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true // Hide the tab bar
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false // Show the tab bar again
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = sections[section]
        // Return 1 for the main cell; add the number of options if expanded
        return sectionData.isExpanded ? 1 + sectionData.options.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = sections[indexPath.section]

        if sectionData.title == "Salary" && indexPath.row == 0 {
            // Handle the SalaryCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "SalaryCell", for: indexPath) as! SalaryInputCell
            cell.delegate = self // Set the delegate to handle slider changes
//            cell.configure(minSalary: sectionData.minSalary, maxSalary: sectionData.maxSalary) // Pass salary values to the cell
            return cell
        }

        if indexPath.row == 0 {
            // Main cell for dropdown sections
            let cell = tableView.dequeueReusableCell(withIdentifier: "dropdownCell", for: indexPath) as! dropdownCell
            let labelTitle = sectionData.selectedOption ?? "Select an option"
            cell.configure(with: sectionData.title)
            cell.configureSelectedOption(with: labelTitle)
            return cell
        } else {
            // Dropdown option cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
            cell.textLabel?.text = sectionData.options[indexPath.row - 1]
            return cell
        }
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sectionData = sections[indexPath.section]

        if indexPath.row == 0 {
            // Toggle dropdown visibility
            sectionData.isExpanded.toggle()
            sections[indexPath.section] = sectionData
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else {
            // Update the selected option
            let selectedOption = sectionData.options[indexPath.row - 1]
            sectionData.selectedOption = selectedOption
            sectionData.isExpanded = false // Collapse the dropdown
            sections[indexPath.section] = sectionData

            // Reload the section to update the "Select an option" label
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }

   
    
    // MARK: - Footer with "Apply Now" Button
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == sections.count - 1 { // Last section
            let footerView = UIView()
            let button = UIButton(type: .system)
            button.setTitle("APPLY NOW", for: .normal)
            button.backgroundColor = .purple
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(applyNowTapped), for: .touchUpInside)
            footerView.addSubview(button)

            // Add button constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
                button.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.9),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
            return footerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == sections.count - 1 ? 100 : 0
    }
    
    // MARK: - Apply Now Button Action
    
    @objc func applyNowTapped() {
        var selectedOptions: [String: String] = [:]

        for section in sections {
            if let selectedOption = section.selectedOption {
                selectedOptions[section.title] = selectedOption
            }

            if section.title == "Salary" {
                let minSalary = section.minSalary != nil ? "\(section.minSalary!)" : "N/A"
                let maxSalary = section.maxSalary != nil ? "\(section.maxSalary!)" : "N/A"
                selectedOptions[section.title] = "Min: \(minSalary), Max: \(maxSalary)"
            }
        }

        let alert = UIAlertController(
            title: "Applied Filters",
            message: selectedOptions.map { "\($0.key): \($0.value)" }.joined(separator: "\n"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - SalaryInputCell Delegate

extension advancedFiltersViewController: SalaryInputCellDelegate {
    func didUpdateSalary(minSalary: Int?, maxSalary: Int?) {
        if let index = sections.firstIndex(where: { $0.title == "Salary" }) {
            sections[index].minSalary = minSalary
            sections[index].maxSalary = maxSalary
        }
    }
    }

//func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    let sectionData = sections[indexPath.section]
//    if sectionData.title == "Salary" && indexPath.row == 0 {
//            return 1000 // Adjust to match the SalaryInputCell design
//        }
//    return 500 // Adjust as needed
//    
//}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


