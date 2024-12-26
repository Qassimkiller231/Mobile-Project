//
//  ManageExperienceTableViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit

class ManageExperienceTableViewController: UITableViewController {

    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var dateStartedPicker: UIDatePicker!
    @IBOutlet weak var dateEndedPicker: UIDatePicker!
    @IBOutlet weak var cityTextField: UITextField!

    
    var experienceToEdit: Experience?  // The Experience object passed from the parent
    var isEditingExperience: Bool = false // Flag to know if we're editing or adding
    var jobSeeker: JobSeeker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Job Seeker in TVC: \(jobSeeker?.experiences.count ?? 0)")
        print("Is editing experience in TVC: \(isEditingExperience)")
        print("Experience to edit in TVC: \(experienceToEdit?.jobTitle ?? "None")")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Only update the form if we're in editing mode
        if isEditingExperience, let experience = experienceToEdit {
            // Pre-fill the form fields if we're editing an existing experience
            jobTitleTextField.text = experience.jobTitle
            companyNameTextField.text = experience.companyName
            cityTextField.text = experience.city
            
            // Date formatting
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"  // Match the date format you use in your model
            
            // Set the date pickers if the start and end dates exist
            if let startDate = dateFormatter.date(from: experience.startDate) {
                dateStartedPicker.date = startDate
            }
            
            if let endDate = dateFormatter.date(from: experience.endDate) {
                dateEndedPicker.date = endDate
            }
        } else {
            // If not editing, clear the fields
            clearFields()
        }
    }
    
    func clearFields() {
        jobTitleTextField.text = ""
        companyNameTextField.text = ""
        dateStartedPicker.date = Date()
        dateEndedPicker.date = Date()
        cityTextField.text = ""
    }
    
    func saveExperience(isEditing: Bool, experienceToEdit: Experience?, completion: @escaping (Experience) -> Void) {
        guard let jobTitle = jobTitleTextField.text,
              let companyName = companyNameTextField.text,
              let city = cityTextField.text
        else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let startDate = dateFormatter.string(from: dateStartedPicker.date)
        let endDate = dateFormatter.string(from: dateEndedPicker.date)
        
        let newExperience = Experience(
            jobTitle: jobTitle,
            companyName: companyName,
            startDate: startDate,
            endDate: endDate,
            city: city
        )
        
        // Call the completion handler with the new or updated experience
        completion(newExperience)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
}
