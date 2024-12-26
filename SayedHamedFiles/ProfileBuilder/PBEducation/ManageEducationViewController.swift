//
//  ManageEducationViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit

class ManageEducationViewController: UIViewController {

    @IBOutlet weak var manageLabel: UILabel!
    var isEditingEducation: Bool = false
    var educationToEdit: Education?
    var jobSeeker: JobSeeker?
    
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageLabel.text = isEditingEducation ? "Edit Education" : "Add Education"
        
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure the first child is the table view controller
        if let manageEducationTableVC = self.children.first as? ManageEducationTableViewController {
            // Log to check if it's the correct child
            print("Accessed ManageEducationTableViewController correctly.")
            
            // Set the properties
            manageEducationTableVC.jobSeeker = self.jobSeeker
            manageEducationTableVC.isEditingEducation = self.isEditingEducation
            manageEducationTableVC.educationToEdit = self.educationToEdit
            
            // Log to ensure data is set
            print("Passed data to TVC: Job Seeker educations count = \(manageEducationTableVC.jobSeeker?.educations.count ?? 0)")
        } else {
            print("Failed to access ManageEducationTableViewController.")
        }
    }


        

    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let manageTableVC = self.children.first as? ManageEducationTableViewController
            
            // Only save when "Save" is pressed
            manageTableVC?.saveEducation(isEditing: isEditingEducation, educationToEdit: educationToEdit) { [weak self] newEducation in
                if let jobSeeker = self?.jobSeeker {
                    if self?.isEditingEducation == true {
                        // If editing, update the existing education
                        if let index = jobSeeker.educations.firstIndex(where: { $0 == self?.educationToEdit }) {
                            jobSeeker.educations[index] = newEducation
                        }
                    } else {
                        // If adding a new education, append it
                        jobSeeker.educations.append(newEducation)
                    }
                }

                // Dismiss the view and navigate back to the previous screen
                self?.performSegue(withIdentifier: "finishManageEducation", sender: self)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishManageEducation" {
            let educationVC = segue.destination as? PBEducationViewController
            educationVC?.jobSeeker = jobSeeker
        }
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
