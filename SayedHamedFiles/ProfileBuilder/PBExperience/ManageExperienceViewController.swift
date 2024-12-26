//
//  ManageExperienceViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 22/12/2024.
//

import UIKit

class ManageExperienceViewController: UIViewController {

    @IBOutlet weak var manageLabel: UILabel!
    var isEditingExperience: Bool = false
    var experienceToEdit: Experience?
    var jobSeeker: JobSeeker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageLabel.text = isEditingExperience ? "Edit Experience" : "Add Experience"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure the first child is the table view controller
        if let manageExperienceTableVC = self.children.first as? ManageExperienceTableViewController {
            // Log to check if it's the correct child
            print("Accessed ManageExperienceTableViewController correctly.")
            
            // Set the properties
            manageExperienceTableVC.jobSeeker = self.jobSeeker
            manageExperienceTableVC.isEditingExperience = self.isEditingExperience
            manageExperienceTableVC.experienceToEdit = self.experienceToEdit
            
            // Log to ensure data is set
            print("Passed data to TVC: Job Seeker experiences count = \(manageExperienceTableVC.jobSeeker?.experiences.count ?? 0)")
        } else {
            print("Failed to access ManageExperienceTableViewController.")
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let manageTableVC = self.children.first as? ManageExperienceTableViewController
            
        // Only save when "Save" is pressed
        manageTableVC?.saveExperience(isEditing: isEditingExperience, experienceToEdit: experienceToEdit) { [weak self] newExperience in
            if let jobSeeker = self?.jobSeeker {
                if self?.isEditingExperience == true {
                    // If editing, update the existing experience
                    if let index = jobSeeker.experiences.firstIndex(where: { $0 == self?.experienceToEdit }) {
                        jobSeeker.experiences[index] = newExperience
                    }
                } else {
                    // If adding a new experience, append it
                    jobSeeker.experiences.append(newExperience)
                }
            }

            // Dismiss the view and navigate back to the previous screen
            self?.performSegue(withIdentifier: "finishManageExperience", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishManageExperience" {
            let experienceVC = segue.destination as? PBExperienceViewController
            experienceVC?.jobSeeker = jobSeeker
        }
    }
}
