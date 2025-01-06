//
//  JobDetailsViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 24/12/2024.
//

import UIKit

class JobDetailsViewController: UIViewController {
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
            let application = application(dateOfApplication: "", jobSeeker: SampleProfile2)
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
    

    
//     MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsToHomepage" {
            let vc = segue.destination as! JobSeekerHomepageViewController
            vc.currentJob = job
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
