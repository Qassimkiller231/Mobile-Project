//
//  JobApplicationsViewController.swift
//  testfinalfinal
//
//  Created by Guest User on 18/12/2024.
//

import UIKit
import Firebase

class JobApplicationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ApplicationCellDelegate, ApplicationDetailsDelegate, UISearchBarDelegate {

    @IBOutlet weak var applicationsTableView: UITableView!
    
    var currentApplication: application?
    
    var currentJob: job?
    var applications: [application] = []// Keep the original applications array
    var filteredApplications: [application] = [] // Array for search results
    var isSearching: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applicationsTableView.delegate = self
        applicationsTableView.dataSource = self
        applicationsTableView.register(applicationTableViewCell.nib(), forCellReuseIdentifier: applicationTableViewCell.identifier)
        searchBar.delegate = self // Set the search bar delegate

        // Initialize the applications array
        applications = currentJob?.applications ?? []
        applications.sort { $0.isShortlisted && !$1.isShortlisted }
        print("Current Job: \(currentJob?.jobTitle ?? "no job")")
        print("Applications: \(currentJob?.applications?.count ?? 0)")
        print("First Application JobSeeker: \(applications.first?.jobSeeker.firstName ?? "no jobseekr")")
    }
    
    // MARK: - UISearchBarDelegate
    
    // Called when the user types in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // If search text is empty, reset the filtered list
            isSearching = false
            filteredApplications = []
        } else {
            // Filter applications based on the search query
            isSearching = true
            filteredApplications = applications.filter { application in
                return application.jobSeeker.firstName.lowercased().contains(searchText.lowercased()) ||
                application.jobSeeker.lastName.lowercased().contains(searchText.lowercased())
            }
        }
        applicationsTableView.reloadData()
    }

    // Called when the search button is pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss the keyboard
    }

    // Called when the cancel button is tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        applicationsTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredApplications.count : applications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicationsTableView.dequeueReusableCell(withIdentifier: applicationTableViewCell.identifier, for: indexPath) as! applicationTableViewCell
        cell.delegate = self
        
        let application = isSearching ? filteredApplications[indexPath.row] : applications[indexPath.row]
        cell.configure(with: application)
        return cell
    }
    
    // MARK: - ApplicationCellDelegate
    
    func didTapViewDetails(for application: application) {
        currentApplication = application
        performSegue(withIdentifier: "showApplicationDetails", sender: self)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showApplicationDetails" {
            if let destinationVC = segue.destination as? ApplicationDetailsViewController {
                destinationVC.delegate = self
                destinationVC.currentApplication = currentApplication
            }
        }
    }
    
    // MARK: - ApplicationDetailsDelegate
    
    func didUpdateApplication(_ application: application) {
        print("Received updated application: \(application)")
        
        if let index = applications.firstIndex(where: { $0.jobSeeker.email == application.jobSeeker.email }) {
            print("Found application at index \(index), updating...")
            applications[index] = application
            
            // Update filtered applications if searching
            if isSearching {
                if let filteredIndex = filteredApplications.firstIndex(where: { $0.jobSeeker.email == application.jobSeeker.email }) {
                    filteredApplications[filteredIndex] = application
                }
            }
            
            applicationsTableView.reloadData()
        } else {
            print("Application not found")
        }
    }

    func removeApplication(_ application: application) {
        // Step 1: Find the application in the list
        if let index = applications.firstIndex(where: { $0.jobSeeker.email == application.jobSeeker.email }) {
            print("Found application at index \(index), removing...")
            
            // Step 2: Remove the application
            applications.remove(at: index)
            
            // Remove from filtered applications if searching
            if isSearching {
                filteredApplications.removeAll { $0.jobSeeker.email == application.jobSeeker.email }
            }
            
            // Step 3: Reload the table view
            applicationsTableView.reloadData()
        } else {
            print("Application not found")
        }
    }
    
    func acceptCandidate(_ application: application) {
        
            let candidateEmail = application.jobSeeker.email
            
            guard let job = currentJob else {
                print("Job or Company ID not found")
                return
            }
            let companyID = job.companyID
            // Step 1: Create a notification
            let notification = NotificationItem(
                notificationName: "Job Application Accepted",
                notificationDescription: "Congratulations! Your application for \(job.jobTitle) has been accepted.",
                notificationDate: df.string(from: Date()),
                category: "Job Application"
            )
            
            let db = Firestore.firestore()
            
            // Step 2: Send notification to the candidate
            let candidateRef = db.collection("Profiles").whereField("email", isEqualTo: candidateEmail)
            candidateRef.getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents, let document = documents.first else {
                    print("Error fetching candidate profile: \(error?.localizedDescription ?? "No profile found")")
                    return
                }
                
                let candidateID = document.documentID
                let candidateProfileRef = db.collection("Profiles").document(candidateID)
                
                candidateProfileRef.updateData([
                    "notifications": FieldValue.arrayUnion([notification.toDictionary()])
                ]) { error in
                    if let error = error {
                        print("Error sending notification: \(error.localizedDescription)")
                    } else {
                        print("Notification sent successfully to \(candidateEmail)")
                        
                        // Step 3: Remove the job from the company's job list
                        let companyRef = db.collection("Companies").document(companyID)
                        
                        companyRef.updateData([
                            "jobs": FieldValue.arrayRemove([job.jobId])
                        ]) { error in
                            if let error = error {
                                print("Error removing job from company: \(error.localizedDescription)")
                            } else {
                                print("Job removed successfully from company.")
                                
                                // Step 4: Show success alert
                                self.showAlert(title: "Candidate Accepted", message: "You have accepted the candidate and the job has been removed.") {
                                    // Navigate back or update UI
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?() // Execute the completion handler after dismissing the alert
        }))
        self.present(alert, animated: true, completion: nil)
    }

    

}
