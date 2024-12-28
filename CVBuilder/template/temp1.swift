//
//  temp1.swift
//  testfinalfinal
//
//  Created by Hamed on 26/12/2024.
//

import UIKit

class temp1: UIView {

    @IBOutlet weak var progilePic: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var personalSummaryTextView: UITextView!
    @IBOutlet weak var skill1Label: UILabel!
    @IBOutlet weak var skill2Label: UILabel!
    @IBOutlet weak var skill3Label: UILabel!
    @IBOutlet weak var education1Label: UILabel!
    @IBOutlet weak var education2Label: UILabel!
    @IBOutlet weak var education3Label: UILabel!
    @IBOutlet weak var experience1Label: UILabel!
    @IBOutlet weak var experience2Label: UILabel!
    @IBOutlet weak var experience3Label: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func populate(with jobSeeker: JobSeeker) {
           // Profile image
//           progilePic.image = UIImage(named: jobSeeker.profileImage)
           
           // Basic info
           fullNameLabel.text = "\(jobSeeker.firstName) \(jobSeeker.lastName)"
           emailLabel.text = jobSeeker.email
           phoneNumberLabel.text = jobSeeker.phoneNumber
           cityLabel.text = jobSeeker.location
           personalSummaryTextView.text = jobSeeker.personalSummary

        // Skills
            skill1Label.text = (jobSeeker.skills?.count ?? 0) > 0 ? jobSeeker.skills?[0].skillName : ""
            skill2Label.text = (jobSeeker.skills?.count ?? 0) > 1 ? jobSeeker.skills?[1].skillName : ""
            skill3Label.text = (jobSeeker.skills?.count ?? 0) > 2 ? jobSeeker.skills?[2].skillName : ""

            // Education
            education1Label.text = (jobSeeker.educations?.count ?? 0) > 0 ? "\(jobSeeker.educations![0].educationFacility) - \(jobSeeker.educations![0].degree)" : ""
            education2Label.text = (jobSeeker.educations?.count ?? 0) > 1 ? "\(jobSeeker.educations![1].educationFacility) - \(jobSeeker.educations![1].degree)" : ""
            education3Label.text = (jobSeeker.educations?.count ?? 0) > 2 ? "\(jobSeeker.educations![2].educationFacility) - \(jobSeeker.educations![2].degree)" : ""

            // Experience
            experience1Label.text = (jobSeeker.experiences?.count ?? 0) > 0 ? "\(jobSeeker.experiences![0].jobTitle) at \(jobSeeker.experiences![0].companyName)" : ""
            experience2Label.text = (jobSeeker.experiences?.count ?? 0) > 1 ? "\(jobSeeker.experiences![1].jobTitle) at \(jobSeeker.experiences![1].companyName)" : ""
            experience3Label.text = (jobSeeker.experiences?.count ?? 0) > 2 ? "\(jobSeeker.experiences![2].jobTitle) at \(jobSeeker.experiences![2].companyName)" : ""
       }

}
