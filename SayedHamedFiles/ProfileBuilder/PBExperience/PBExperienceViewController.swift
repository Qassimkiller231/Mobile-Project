//
//  PBExperienceViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit

class PBExperienceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExperienceTableViewCellDelegate {
    
    func editExperienceTapped(with experience: Experience) {
        performSegue(withIdentifier: "toManageExperience", sender: experience)
    }
    
    @IBOutlet weak var experienceTableView: UITableView!
    
    var jobSeeker: JobSeeker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experienceTableView.delegate = self
        experienceTableView.dataSource = self
        experienceTableView.register(experienceTableViewCell.nib(), forCellReuseIdentifier: experienceTableViewCell.identifier)  // Register Experience cell
        
        if jobSeeker?.experiences?.isEmpty == true {
            //add sample experience
            jobSeeker?.experiences?.append(Experience(jobTitle: "Master", companyname: "Life", startDate: "13/07/2004", endDate: "23/12/2024", city: "EveryWhere"))
        }
        
        experienceTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobSeeker?.experiences?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "experienceTableViewCell", for: indexPath) as! experienceTableViewCell
        let experience = jobSeeker?.experiences?[indexPath.row]  // Get the experience object from the jobSeeker
        cell.configure(with: experience!)
        cell.delegate = self  // Set the delegate for the cell to the current controller
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toManageExperience" {
            if let manageExperienceVC = segue.destination as? ManageExperienceViewController {
                // Pass jobSeeker to the next controller
                manageExperienceVC.jobSeeker = self.jobSeeker
                
                // Pass the selected experience to edit, or nil if adding new
                if let selectedExperience = sender as? Experience {
                    manageExperienceVC.experienceToEdit = selectedExperience
                    manageExperienceVC.isEditingExperience = true
                } else {
                    manageExperienceVC.isEditingExperience = false
                }
            }
        } else if segue.identifier == "backToSkills" {
            if let skillsVC = segue.destination as? PBSkillsViewController {
                skillsVC.jobSeeker = self.jobSeeker
            }
        }
        else if segue.identifier == "ShowPreferences" {
            // Show an alert asking if the user is sure they want to leave
            if let prefVC = segue.destination as? PBPreferencesViewController {
                prefVC.jobSeeker = self.jobSeeker
            }
            
        }
    }
        @IBAction func addExperienceButtonTapped(_ sender: Any) {
            performSegue(withIdentifier: "toManageExperience", sender: nil)
        }
        
    }
    

