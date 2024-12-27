//
//  applicationTableViewCell.swift
//  testfinalfinal
//
//  Created by Guest User on 18/12/2024.
//

import UIKit

protocol ApplicationCellDelegate: AnyObject {
    func didTapViewDetails(for application: application)
}

class applicationTableViewCell: UITableViewCell {

    @IBOutlet weak var applicantName: UILabel!
    @IBOutlet weak var currentTitle: UILabel!
    @IBOutlet weak var yearsOfExperience: UILabel!
    @IBOutlet weak var dateOfApplication: UILabel!
    @IBOutlet weak var interview: UILabel!
    @IBOutlet weak var shortlisted: UIButton!
    
    weak var delegate: ApplicationCellDelegate?
    var currentApplication: application?
    
    static var identifier = "applicationTableVIewCell"
    static func nib() -> UINib {
        return UINib(nibName: "applicationTableVIewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with application: application) {
        currentApplication = application
        makeDateFormatter()

        // Setting applicant name
        applicantName.text = "\(application.jobSeeker.firstName) \(application.jobSeeker.lastName)"

        // Determining current title (ongoing job or last job)
        if let ongoingExperience = application.jobSeeker.experiences?.first(where: { $0.endDate.lowercased() == "ongoing" }) {
            currentTitle.text = ongoingExperience.jobTitle
        } else if let lastJob = application.jobSeeker.experiences?.sorted(by: { (exp1, exp2) -> Bool in
            guard let date1 = df.date(from: exp1.endDate),
                  let date2 = df.date(from: exp2.endDate) else { return false }
            return date1 > date2
        }).first {
            currentTitle.text = lastJob.jobTitle
        } else {
            currentTitle.text = "No work experience"
        }

        // Calculating total years of experience
            var totalExperience: Double = 0

        if application.jobSeeker.experiences != nil  {
                for experience in application.jobSeeker.experiences! {
                    if let startDate = df.date(from: experience.startDate),
                       let endDate = experience.endDate.lowercased() == "ongoing"
                        ? Date()
                        : df.date(from: experience.endDate) {
                        let experienceDuration = Calendar.current.dateComponents([.month], from: startDate, to: endDate).month ?? 0
                        totalExperience += Double(experienceDuration) / 12.0
                    }
                }

                // Round down the experience to the nearest year
                totalExperience = floor(totalExperience)
                yearsOfExperience.text = String(format: "Years of Experience: %.0f", totalExperience)
            } else {
                yearsOfExperience.text = ""
            }

        // Setting date of application
        dateOfApplication.text = "Date of Application: \(df.string(from: application.dateOfApplication))"
        
        if(application.isShortlisted){
            shortlisted.isHidden = false
        } else {
            shortlisted.isHidden = true
        }
        
        if let inter = application.interview {
            interview.text = "Interview Date: \(inter.interviewDate)"
        } else {
            interview.text = ""
        }
    }


    @IBAction func viewApplicationDetails(_ sender: Any) {
        delegate?.didTapViewDetails(for: currentApplication!)
    }
    

}
