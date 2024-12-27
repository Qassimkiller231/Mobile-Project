//
//  ManageFilterViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 26/12/2024.
//

import UIKit

class ManageFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var selectedSection : Section?
    var selectedType : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(dropdownCell.nib(), forCellReuseIdentifier: dropdownCell.identifier)
        // Do any additional setup after loading the view.
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 + (selectedSection?.options?.count ?? 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
            cell.textLabel?.text = selectedSection?.title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
            cell.textLabel?.text = selectedSection?.options![indexPath.row - 1]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            selectedType = selectedSection?.options![indexPath.row - 1]
        }
    }
    
    func deleteType() {
        // Check if a type is selected
        guard let selectedType = selectedType else {
            // Show an alert to choose a type
            let alert = UIAlertController(title: "No Type Selected", message: "Please select a type to delete.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        self.selectedSection?.options?.removeAll(where: { $0 == selectedType })
                    self.selectedType = nil // Clear the selected type
                    self.tableView.reloadData() // Update the table view
        
        // Show confirmation alert
//        let confirmationAlert = UIAlertController(
//            title: "Delete Type",
//            message: "Are you sure you want to delete the type '\(selectedType)'?",
//            preferredStyle: .alert
//        )
//        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        confirmationAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
//            // Perform deletion
//            self.selectedSection?.options?.removeAll(where: { $0 == selectedType })
//            self.selectedType = nil // Clear the selected type
//            self.tableView.reloadData() // Update the table view
//        }))
        
//        present(confirmationAlert, animated: true)
    }
    
    @IBAction func deleteTypeButtonTapped(_ sender: UIButton) {
        deleteType()
    }
    @IBAction func deleteChangesButtonTapped(_ sender: UIButton) {
        // Show a confirmation alert before navigating back
        let alert = UIAlertController(
            title: "Delete Changes",
            message: "Are you sure you want to discard all changes and go back?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { _ in
            // Navigate back to the previous view controller
            self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        // Validate the changes (if needed)
        guard let updatedSection = selectedSection else {
            let alert = UIAlertController(title: "Error", message: "No section selected to save changes.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
            return
        }

        // Update the sections array
        if let sectionIndex = adminSections.firstIndex(where: { $0.title == updatedSection.title }) {
            adminSections[sectionIndex] = updatedSection
        }

        // Notify the previous controller to reload its data
        if let previousVC = navigationController?.viewControllers.last as? AdminAdvancedFiltersViewController {
            previousVC.tableView.reloadData()
        }

        // Navigate back to the previous view controller
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addTypeButtonTapped(_ sender: UIButton) {
        // Show an alert with a text input field
        showInputAlert(title: "Add New Type",
                       message: "Enter the name of the new type you want to add.",
                       placeholder: "Type Name") { [weak self] userInput in
            guard let self = self else { return } // Avoid retain cycles
            if let input = userInput?.trimmingCharacters(in: .whitespacesAndNewlines), !input.isEmpty {
                // Add the input to the selectedSection's options
                self.selectedSection?.options?.append(input)
                
                // Reload the table view to show the updated options
                self.tableView.reloadData()
                
                // Optional: Log or inform the user of success
                print("Added new type: \(input)")
            } else {
                // Optional: Show an error if input is invalid
                self.showError("The type name cannot be empty.")
            }
        }
    }

    // Helper function to show an error alert
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showInputAlert(title: String, message: String, placeholder: String, completion: @escaping (String?) -> Void) {
        // Create the alert controller
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Add a text field to the alert
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }

        // Add a "Cancel" action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // Add a "Submit" action
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            // Pass the input back to the caller
            let userInput = alert.textFields?.first?.text
            completion(userInput)
        }))

        // Present the alert
        self.present(alert, animated: true, completion: nil)
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
