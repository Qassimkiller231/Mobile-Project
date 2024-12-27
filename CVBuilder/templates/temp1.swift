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
        skill1Label.text = ((jobSeeker.skills?.indices.contains(0)) != nil) ? jobSeeker.skills?[0].skillName : ""
        skill2Label.text = ((jobSeeker.skills?.indices.contains(1)) != nil) ? jobSeeker.skills?[1].skillName : ""
        skill3Label.text = ((jobSeeker.skills?.indices.contains(2)) != nil) ? jobSeeker.skills?[2].skillName : ""

           // Education
        education1Label.text = ((jobSeeker.educations?.indices.contains(0)) != nil) ? "\(String(describing: jobSeeker.educations?[0].educationFacility)) - \(String(describing: jobSeeker.educations?[0].degree))" : ""
        education2Label.text = ((jobSeeker.educations?.indices.contains(1)) != nil) ? "\(String(describing: jobSeeker.educations?[1].educationFacility)) - \(String(describing: jobSeeker.educations?[1].degree))" : ""
        education3Label.text = ((jobSeeker.educations?.indices.contains(2)) != nil) ? "\(String(describing: jobSeeker.educations?[2].educationFacility)) - \(String(describing: jobSeeker.educations?[2].degree))" : ""

           // Experience
        experience1Label.text = ((jobSeeker.experiences?.indices.contains(0)) != nil) ? "\(String(describing: jobSeeker.experiences?[0].jobTitle)) at \(String(describing: jobSeeker.experiences?[0].companyName))" : ""
        experience2Label.text = ((jobSeeker.experiences?.indices.contains(1)) != nil) ? "\(String(describing: jobSeeker.experiences?[1].jobTitle)) at \(String(describing: jobSeeker.experiences?[1].companyName))" : ""
        experience3Label.text = ((jobSeeker.experiences?.indices.contains(2)) != nil) ? "\(String(describing: jobSeeker.experiences?[2].jobTitle)) at \(String(describing: jobSeeker.experiences?[2].companyName))" : ""
       }

}
