//
//  PBEducationViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit

class PBEducationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EducationTableViewCellDelegate{
    func editEducationTapped(with education: Education) {
        performSegue(withIdentifier: "toManageEducation", sender: education)
    }
    
    
    @IBOutlet weak var educationsTableView: UITableView!
    var jobSeeker: JobSeeker?
    override func viewDidLoad() {
        super.viewDidLoad()
        educationsTableView.delegate = self
        educationsTableView.dataSource = self
        educationsTableView.register(educationTableViewCell.nib(), forCellReuseIdentifier: educationTableViewCell.identifier)
        if jobSeeker?.educations.isEmpty == true {
                jobSeeker?.educations.append(Education(educationFacility: "eduFac1", educationLevel: "eduLevel1", degree: "eduDegree1", startDate: "12/12/21", endDate: "20/12/23", city: "Muharraq"))
            
            print("this should be added")
            }
        
        educationsTableView.reloadData()
    }

    
   

  
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Row count: \(jobSeeker?.educations.count ?? 99)")
        return jobSeeker?.educations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "educationTableViewCell", for: indexPath) as! educationTableViewCell
        let education = jobSeeker?.educations[indexPath.row]  // Get the education object from the jobSeeker
        
        cell.configure(with: education!)
        cell.delegate = self  // Set the delegate for the cell to the current controller
        return cell
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toManageEducation" {
                if let manageEducationVC = segue.destination as? ManageEducationViewController {
                    // Pass jobSeeker to the next controller
                    manageEducationVC.jobSeeker = self.jobSeeker

                    // Pass the selected education to edit, or nil if adding new
                    if let selectedEducation = sender as? Education {
                        manageEducationVC.educationToEdit = selectedEducation
                        manageEducationVC.isEditingEducation = true
                    } else {
                        manageEducationVC.isEditingEducation = false
                    }
                }
        } else if (segue.identifier == "ShowSkills") {
            if let skillsVC = segue.destination as? PBSkillsViewController {
                skillsVC.jobSeeker = self.jobSeeker
            }
        } else if (segue.identifier == "ShowPersonal") {
            // Show an alert asking if the user is sure they want to leave
            let alert = UIAlertController(
                title: "Lose Changes",
                message: "You have unsaved changes. Are you sure you want to leave without saving?",
                preferredStyle: .alert
            )
            
            // Add "Leave" button
            alert.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: { _ in
                // Proceed with the segue
                if let personalVC = segue.destination as? PBPersonalViewController {
                    personalVC.personalTableViewController?.jobSeeker = self.jobSeeker
                }
            }))
            
            // Add "Cancel" button
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Present the alert
            self.present(alert, animated: true, completion: nil)
            
            // Prevent the segue from happening immediately
            return
        } else {
            if let personalVC = segue.destination as? PBPersonalViewController {
                personalVC.personalTableViewController?.jobSeeker = self.jobSeeker
            }
            
        }
    }
    


    
    @IBAction func addEducationButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toManageEducation", sender: nil)
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
