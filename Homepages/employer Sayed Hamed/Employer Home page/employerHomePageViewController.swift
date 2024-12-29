//
//  JobSeekerHomepageViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class employerHomePage: UIViewController,UITableViewDelegate,UITableViewDataSource, EmployerJobListinCellDelegate{
    
    
    
    func didTapViewApplications(cell: EmployerJobListingCardTableViewCell) {
        // Get the indexPath of the tapped cell
               guard let indexPath = tableView.indexPath(for: cell) else {
                   print("Error: Could not find indexPath for cell")
                   return
               }
               // Get the corresponding job object
               let selectedJob = jobs[indexPath.row]

               // Navigate to JobApplicationsViewController
               let storyboard = UIStoryboard(name: "employerHomePage", bundle: nil) // Replace "Main" with the storyboard containing JobApplicationsViewController
               guard let jobApplicationsVC = storyboard.instantiateViewController(withIdentifier: "JobApplicationsViewController") as? JobApplicationsViewController else {
                   print("Error: Could not instantiate JobApplicationsViewController")
                   return
               }
                print("Selected job: \(selectedJob.jobTitle)")
               // Pass the selected job to JobApplicationsViewController
        jobApplicationsVC.currentJob = selectedJob

               // Push JobApplicationsViewController to the navigation stack
               navigationController?.pushViewController(jobApplicationsVC, animated: true)
    }
    
    func didTapEditJobListingCard(cell: EmployerJobListingCardTableViewCell) {
        return
    }
    
    
    

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var CompanyJobs : [job] = jobs
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOverlayButton(_:)))
            profilePicImage.addGestureRecognizer(tapGesture)
            
            // Set up layout
//            table view commands
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(EmployerJobListingCardTableViewCell.nib(), forCellReuseIdentifier: EmployerJobListingCardTableViewCell.identifier)
            
            
            if Utilities.DataManager.profile == nil {
                if let tabBarController = self.tabBarController {
                    tabBarController.selectedIndex = 2 // Replace '2' with the index of the tab you want to switch to
                }
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CompanyJobs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployerJobListingCardTableViewCell.identifier, for: indexPath) as! EmployerJobListingCardTableViewCell
        cell.delegate = self
        cell.configure(with: CompanyJobs[indexPath.row])
        return cell
    }
    
    
    
    @IBAction func showOverlayButton(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
            
            // Instantiate ProfileOverlayViewController
            let overlayVC = ProfileOverlayViewController(nibName: "ProfileOverlayViewController", bundle: nil)
            
            // Set the presentation style for an overlay effect
            overlayVC.modalPresentationStyle = .overCurrentContext
            overlayVC.modalTransitionStyle = .crossDissolve // Smooth fade-in effect
            
            // Present the overlay and show the tab bar again after dismissing
            overlayVC.dismissCompletion = { [weak self] in
                self?.tabBarController?.tabBar.isHidden = false
            }
            
            self.present(overlayVC, animated: true, completion: nil)
    }
    
    }



    
//    Table view functions
    
    

