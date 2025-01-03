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
        // Do any additional setup after loading the view.
    }
    
    func addSampleApplications() {
        // Assuming sampleJobs is already populated
        sampleJobs[0].applications = [sampleApplications[0]]
        sampleJobs[1].applications = [sampleApplications[1]]
        sampleJobs[2].applications = [sampleApplications[2]]
        sampleJobs[3].applications = [sampleApplications[3]]
        sampleJobs[4].applications = [sampleApplications[4]]
        sampleJobs[5].applications = [sampleApplications[5]]
        sampleJobs[6].applications = [sampleApplications[6]]
        sampleJobs[7].applications = [sampleApplications[7]]

        // Assuming sampleJobs and sampleApplications are populated

        // Loop through each job and its applications to assign the jobTitle
        // Assign job titles to the applications
//        for jobIndex in 0..<sampleJobs.count {
//            // Access the job and make sure it's mutable
//            let job = sampleJobs[jobIndex]
//            
//            
//            // Safely unwrap the applications array for this job
//            if var applications = job.applications {
//                // Loop through each application
//                for appIndex in 0..<applications.count {
//                    // Access each application and modify the jobTitle
//                    var application = applications[appIndex]
//                    application.jobTitle = job.jobTitle  // Set jobTitle from the job
//                    // Put the modified application back into the applications array
//                    applications[appIndex] = application
//                }
//                
//                // After modifying the applications, assign it back to the job
//                job.applications = applications
//                
//                // Update the sampleJobs array with the modified job
//                sampleJobs[jobIndex] = job
//            }
            
        sampleApplications[0].jobTitle = sampleJobs[0].jobTitle
        sampleApplications[1].jobTitle = sampleJobs[1].jobTitle
        sampleApplications[2].jobTitle = sampleJobs[2].jobTitle
        sampleApplications[3].jobTitle = sampleJobs[3].jobTitle
        sampleApplications[4].jobTitle = sampleJobs[4].jobTitle
        sampleApplications[5].jobTitle = sampleJobs[5].jobTitle
        sampleApplications[6].jobTitle = sampleJobs[6].jobTitle
        sampleApplications[7].jobTitle = sampleJobs[7].jobTitle
     
        
            
        sampleApplications[0].interview = sampleInterviews[0]
        sampleApplications[1].interview = sampleInterviews[1]
        sampleApplications[2].interview = sampleInterviews[2]
        sampleApplications[3].interview = sampleInterviews[3]
        sampleApplications[4].interview = sampleInterviews[4]
        sampleApplications[5].interview = sampleInterviews[5]
        sampleApplications[6].interview = sampleInterviews[6]
        sampleApplications[7].interview = sampleInterviews[7]


        
        }
        



        

    func filterApplicationsByProfile(applications: [application], profile: JobSeeker) -> [application] {
        return applications.filter { $0.jobSeeker.userID == profile.userID }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredApplications.count)
        return filteredApplications.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: applicationHistoryTableViewCell.identifier, for: indexPath) as! applicationHistoryTableViewCell
        if indexPath.row == 0 {
            if tableView == interviewTableView {
                cell.configureInterviewHeader()
            } else {
                cell.configureApplicationHeader()
            }
        }else {
            if tableView == interviewTableView{
                cell.configureInterview(with: filteredApplications[indexPath.row - 1])}
            else {
                cell.configure(with: filteredApplications[indexPath.row - 1])
            }
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
