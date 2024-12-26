//
//  JobApplicationsViewController.swift
//  testfinalfinal
//
//  Created by Guest User on 18/12/2024.
//

import UIKit

class JobApplicationsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, ApplicationCellDelegate,ApplicationDetailsDelegate{

    @IBOutlet weak var applicationsTableView: UITableView!
    var currentApplication: application?

    override func viewDidLoad() {
        super.viewDidLoad()
        applicationsTableView.delegate = self
        applicationsTableView.dataSource = self
        applicationsTableView.register(applicationTableViewCell.nib(), forCellReuseIdentifier: applicationTableViewCell.identifier)
        // Do any additional setup after loading the view.
        applications.sort { $0.isShortlisted && !$1.isShortlisted }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applicationsTableView.dequeueReusableCell(withIdentifier: applicationTableViewCell.identifier, for: indexPath) as! applicationTableViewCell
        cell.delegate = self
        cell.configure(with: applications[indexPath.row])
        return cell
        
    }
    
    func didTapViewDetails(for application: application) {
        currentApplication = application
        performSegue(withIdentifier: "showApplicationDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showApplicationDetails" {
            if let destinationVC = segue.destination as? ApplicationDetailsViewController {
                destinationVC.delegate = self
                destinationVC.currentApplication = currentApplication
            }
        }
    }
    
    func didUpdateApplication(_ application: application) {
        print("Received updated application: \(application)")
        
        if let index = applications.firstIndex(where: { $0.jobSeeker.email == application.jobSeeker.email }) {
            print("Found application at index \(index), updating...")
            applications[index] = application
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
               
               // Step 3: Reload the table view
               applicationsTableView.reloadData()
           } else {
               print("Application not found")
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
