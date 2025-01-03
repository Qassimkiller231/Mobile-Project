//
//  page3ViewController.swift
//  M12
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 09/12/2024.
//

import UIKit

class JobRecommendationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var jobRecommendations : [job] = []
    var profile = SampleProfile2
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JobRecommendationsTableViewCell.nib(), forCellReuseIdentifier: JobRecommendationsTableViewCell.identifer)
        jobRecommendations = filterJobs(basedOn: SampleProfile2, from: sampleJobs2)
        // Do any additional setup after loading the view.
    }
    func filterJobs(basedOn profile: JobSeeker, from jobs: [job]) -> [job] {
        return jobs.filter { job in
            // Check if any jobSkill matches the JobSeeker's preferences
            return job.jobSkills.contains { skill in
                profile.preferences?.contains(skill) ?? false
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobRecommendations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobRecommendationsTableViewCell.identifer, for: indexPath) as! JobRecommendationsTableViewCell
        cell.configure(with: jobRecommendations[indexPath.row])
        cell.applyButtonTapped = {
            self.goToJobDetails(job: self.jobRecommendations[indexPath.row])
        }
        return cell
    }
    func goToJobDetails(job: job) {
        let storyboard = UIStoryboard(name: "JobSeekerLoginPage", bundle: nil)
        let jobDetailsVC = storyboard.instantiateViewController(identifier:"jobDetails") as? JobDetailsViewController
        jobDetailsVC?.job = job
        navigationController?.pushViewController(jobDetailsVC!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 283
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
