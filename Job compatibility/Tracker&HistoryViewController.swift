//
//  Tracker&HistoryViewController.swift
//  testfinalfinal
//
//  Created by Scoobysnac on 23/12/2024.
//

import UIKit

class Tracker_HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var interviewTableView: UITableView!
    var filteredApplications : [application] = []
    var currentProfile : JobSeeker?
    override func viewDidLoad() {
        currentProfile = SampleProfile
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        interviewTableView.dataSource = self
        interviewTableView.delegate = self
        addSampleApplications()
        filteredApplications = filterApplicationsByProfile(applications: sampleApplications, profile: currentProfile! )
        tableView.register(applicationHistoryTableViewCell.nib(), forCellReuseIdentifier: applicationHistoryTableViewCell.identifier)
        interviewTableView.register(applicationHistoryTableViewCell.nib(), forCellReuseIdentifier: applicationHistoryTableViewCell.identifier)
        print(sampleJobs[1].jobTitle)
        // Do any additional setup after loading the view.
    }
    func addSampleApplications() {
        // Assuming sampleJobs is already populated
        sampleJobs[0].applications = [sampleApplications[0], sampleApplications[1], sampleApplications[2]]  // Job 1
        sampleJobs[1].applications = [sampleApplications[3], sampleApplications[4], sampleApplications[5]]  // Job 2
        sampleJobs[2].applications = [sampleApplications[6], sampleApplications[7], sampleApplications[8]]  // Job 3
        sampleJobs[3].applications = [sampleApplications[9], sampleApplications[10], sampleApplications[11]] // Job 4
        sampleJobs[4].applications = [sampleApplications[12], sampleApplications[13], sampleApplications[14]] // Job 5
        sampleJobs[5].applications = [sampleApplications[15], sampleApplications[16], sampleApplications[17]] // Job 6
        sampleJobs[6].applications = [sampleApplications[18], sampleApplications[19]] // Job 7
        
        // Assuming sampleJobs and sampleApplications are populated

        // Loop through each job and its applications to assign the jobTitle
        // Assign job titles to the applications
        for jobIndex in 0..<sampleJobs.count {
            // Access the job and make sure it's mutable
            let job = sampleJobs[jobIndex]
            
            // Safely unwrap the applications array for this job
            if var applications = job.applications {
                // Loop through each application
                for appIndex in 0..<applications.count {
                    // Access each application and modify the jobTitle
                    var application = applications[appIndex]
                    application.jobTitle = job.jobTitle  // Set jobTitle from the job
                    
                    // Put the modified application back into the applications array
                    applications[appIndex] = application
                }
                
                // After modifying the applications, assign it back to the job
                job.applications = applications
                
                // Update the sampleJobs array with the modified job
                sampleJobs[jobIndex] = job
            }
        }




        

    }
    func filterApplicationsByProfile(applications: [application], profile: JobSeeker) -> [application] {
        return applications.filter { $0.jobSeeker.userID == profile.userID }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredApplications.count)
        return filteredApplications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: applicationHistoryTableViewCell.identifier, for: indexPath) as! applicationHistoryTableViewCell
        if tableView == interviewTableView {
            
        } else if indexPath.row != 0{
            cell.configure(with: filteredApplications[indexPath.row])
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func jobCompatibilityButtonPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
    }
}
