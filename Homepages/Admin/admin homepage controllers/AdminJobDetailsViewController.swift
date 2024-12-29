//
//  JobDetailsViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 24/12/2024.
//

import UIKit

class AdminJobDetailsViewController: UIViewController {
    var job : job?
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var aboutUsTextLabel: UILabel!
    
    @IBOutlet weak var offerTextLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = job?.jobTitle
//        profilePic.image = UIImage(named: job!.jobImage)
        descriptionTextLabel.text = job?.jobDescription
        aboutUsTextLabel.text = job?.company.aboutUs
        offerTextLabel.text = job?.offer
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func ApplyButtonTapped(_ sender: Any) {
        showAlert(message: "Do you want to apply to this Job?") {
            if self .job?.applications == nil {
                self .job?.applications = []
            }
            let application = application(dateOfApplication: "", jobSeeker: JobSeekerSample)
            self.job?.applications?.append(application)
            self.performSegue(withIdentifier: "detailsToHomepage", sender: nil)
            print("added application from alert, count is\(self.job?.applications?.count ?? 0)")
        } onNo: {
            print("ok")
        }
    }
    func showAlert(message: String, onYes: @escaping () -> Void, onNo: @escaping () -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            onYes()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
            onNo()
        }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteJobButtonTapped(_ sender: UIButton) {
        promptAndDeleteJob()
    }
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        saveChangesToJob()
    }
    
    

    
//     MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsToEditAboutUs" {
            let vc = segue.destination as! adminJobDetailsOverlayViewController
            vc.editTitle = "Edit About Us"
            vc.editDescription = job!.company.aboutUs
            vc.delegate = self
        }
        if segue.identifier == "detailsToEditOffer" {
            let vc = segue.destination as! adminJobDetailsOverlayViewController
            vc.editTitle = "Edit Offer"
            vc.editDescription = job!.offer
            vc.delegate = self
        }
        if segue.identifier == "detailsToEditDescription" {
            let vc = segue.destination as! adminJobDetailsOverlayViewController
            vc.editTitle = "Edit Description"
            vc.editDescription = job!.jobDescription
            vc.delegate = self
        }
        if segue.identifier == "detailsToHomepage" {
            let vc = segue.destination as! JobSeekerHomepageViewController
            vc.currentJob = job
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    func promptAndDeleteJob() {
        let alert = UIAlertController(
            title: "Delete Job",
            message: "Are you sure you want to delete this job? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            // Perform deletion
            if let jobIndex = jobs.firstIndex(where: { $0.jobId == self.job?.jobId }) {
                print(self.job?.jobTitle ?? "")
                jobs.remove(at: jobIndex)
                print(jobs.count)
                print("Job deleted successfully")
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Job not found in the array")
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveChangesToJob() {
        guard let updatedJob = job else { return }
        
        updatedJob.jobDescription = descriptionTextLabel.text ?? ""
        updatedJob.company.aboutUs = aboutUsTextLabel.text ?? ""
        updatedJob.offer = offerTextLabel.text ?? ""
        
        if let jobIndex = jobs.firstIndex(where: { $0.jobId == updatedJob.jobId }) {
            jobs[jobIndex] = updatedJob
            print("Job updated successfully")
            // Optionally, pop the view controller or show a success alert
            let successAlert = UIAlertController(
                title: "Success",
                message: "Changes saved successfully.",
                preferredStyle: .alert
            )
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(successAlert, animated: true, completion: nil)
        } else {
            print("Job not found in the array")
        }
    }
    

}
extension AdminJobDetailsViewController: EditDescriptionDelegate {
    func didUpdateDescription(_ updatedDescription: String,  _ title: String) {
        // Update the UI or model with the new description
        if title == "Edit About Us" {
            aboutUsTextLabel.text = updatedDescription
        } else if title == "Edit Offer" {
            offerTextLabel.text = updatedDescription
        } else if title == "Edit Description" {
            descriptionTextLabel.text = updatedDescription
        }
        print("Updated description: \(updatedDescription)")
    }
}
