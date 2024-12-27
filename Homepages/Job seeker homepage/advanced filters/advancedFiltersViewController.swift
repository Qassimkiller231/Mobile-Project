//
//  advancedFiltersViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 13/12/2024.
//

import UIKit

class advancedFiltersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
//    add an outlet to the tableview
    var selectedOptions: [String: String] = [:]
    var selectedFilters: [String: String] = [:] // Store selected filters

    override func viewDidLoad() {
        super.viewDidLoad()
//        add and register the dropdownCell nib
        let nib = UINib(nibName: "dropdownCell", bundle: nil)
            table.register(nib, forCellReuseIdentifier: "dropdownCell")
        
//        add and register the salaryNib
        let salaryNib = UINib(nibName: "SalaryCell", bundle: nil)
           table.register(salaryNib, forCellReuseIdentifier: "SalaryCell")
        
//        conform to the delegate and datasource subclasses
        table.dataSource = self
        table.delegate = self
        
    }
//    update the viewWillAppear so that the tabBar is hidden in this page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true // Hide the tab bar
    }
    
    
// add the tabbar back before going to another page
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false // Show the tab bar again
    }
    
    
//    specify the number of sections based on the sections array
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

//    specify the number of rows depending on the sectiondata
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = sections[section]
                                   
        // Return 1 for the main cell; add the number of options if expanded
        return sectionData.isExpanded ? 1 + (sectionData.options?.count ?? 0) : 1
    }

    
    
    
//    Specify what does each cell need to do
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        take the sectionData
        let sectionData = sections[indexPath.section]
        
//        if the section is the salary section, take the salaryCell
        if sectionData.title == "Salary" && indexPath.row == 0 {
            // Handle the SalaryCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "SalaryCell", for: indexPath) as! SalaryInputCell
            return cell
        }
        
//        if it is the first row in the section, meaning it is not an option, hence use the dropdownCell
        if indexPath.row == 0 {
            // Main cell for dropdown sections
            let cell = tableView.dequeueReusableCell(withIdentifier: "dropdownCell", for: indexPath) as! dropdownCell
//            check if there is a selectionOption in the object, otherwise type select an option
            let labelTitle = sectionData.selectedOption ?? "Select an option"
            cell.configure(with: sectionData.title)
            cell.configureSelectedOption(with: labelTitle)
            
            return cell
        } else {
            // Dropdown option cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
//        -1 because this started in the second row
            cell.textLabel?.text = sectionData.options?[indexPath.row - 1]
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
            let selectedOption = sectionData.options?[indexPath.row - 1]
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
            
            // Create Apply Now button
            let applyButton = UIButton(type: .system)
            applyButton.setTitle("APPLY NOW", for: .normal)
            applyButton.backgroundColor = .purple
            applyButton.setTitleColor(.white, for: .normal)
            applyButton.layer.cornerRadius = 8
            applyButton.addTarget(self, action: #selector(applyNowTapped), for: .touchUpInside)
            
            // Create Reset Filters button
            let resetButton = UIButton(type: .system)
            resetButton.setTitle("RESET FILTERS", for: .normal)
            resetButton.backgroundColor = .red
            resetButton.setTitleColor(.white, for: .normal)
            resetButton.layer.cornerRadius = 8
            resetButton.addTarget(self, action: #selector(resetFiltersTapped), for: .touchUpInside)
            
            // Create a horizontal stack view to hold both buttons
            let stackView = UIStackView(arrangedSubviews: [applyButton, resetButton])
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 16
            
            // Add stack view to footerView
            footerView.addSubview(stackView)
            
            // Add constraints for stack view
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
                stackView.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.9),
                stackView.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            return footerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == sections.count - 1 ? 100 : 0
    }
    
    // MARK: - Apply Now Button Action
    @objc func resetFiltersTapped() {
        print("Reset Filters button tapped")
        
        // Iterate through all sections and reset their filters
        for i in 0..<sections.count {
            var section = sections[i]
            section.selectedOption = nil // Clear the selected dropdown option
            section.isExpanded = false // Collapse the dropdown if expanded
            if section.title == "Salary" {
                section.minSalary = nil // Reset minimum salary
                section.maxSalary = nil // Reset maximum salary
            }
            sections[i] = section // Update the section in the array
        }
        
        // Reload the table view to reflect changes
        table.reloadData()
        
        // Clear selectedFilters dictionary
        selectedFilters.removeAll()
        
        // Optionally show an alert or confirmation
        let alert = UIAlertController(title: "Filters Reset", message: "All filters have been cleared.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    @objc func applyNowTapped() {
        var selectedFilters: [String: String] = [:]

            for section in sections {
                if let selectedOption = section.selectedOption {
                    selectedFilters[section.title] = selectedOption
                }
                if section.title == "Salary" {
                    let minSalary = section.minSalary != nil ? "\(section.minSalary!)" : "N/A"
                    let maxSalary = section.maxSalary != nil ? "\(section.maxSalary!)" : "N/A"
                    selectedFilters[section.title] = "Min: \(minSalary), Max: \(maxSalary)"
                }
            }

            // Store filters for later use in unwindToHomepage
            self.selectedFilters = selectedFilters
        performSegue(withIdentifier: "unwindToHomepage", sender: self)
//        let alert = UIAlertController(
//            title: "Applied Filters",
//            message: selectedOptions.map { "\($0.key): \($0.value)" }.joined(separator: "\n"),
//            preferredStyle: .alert
//        )
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
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


