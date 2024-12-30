//
//  applicationHistoryTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 22/12/2024.
//

import UIKit

class applicationHistoryTableViewCell: UITableViewCell {
@IBOutlet weak var applicationNameLabel: UILabel!
@IBOutlet weak var applicationStatusLabel: UILabel!
@IBOutlet weak var dateStartedLabel: UILabel!
@IBOutlet weak var dateEndLabel: UILabel!
@IBOutlet weak var containerView: UIView!
    
    static var identifier = "applicationHistoryTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "applicationHistoryTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupShadow() {
        // Add rounded corners
            containerView.layer.cornerRadius = 12
            containerView.layer.masksToBounds = false // Allow shadow to extend beyond bounds
            
            // Set a background color for the container
        containerView.backgroundColor = UIColor.purple // or your desired color
            
            // Add shadow properties
            containerView.layer.shadowColor = UIColor.black.cgColor // Shadow color
            containerView.layer.shadowOpacity = 0.15 // Soft shadow (adjust as needed)
            containerView.layer.shadowOffset = CGSize(width: 0, height: 4) // Slight drop shadow
            containerView.layer.shadowRadius = 8 // Soft and diffused shadow
            
            // Optional: Add a light border (for extra definition)
            containerView.layer.borderWidth = 0.5
            containerView.layer.borderColor = UIColor.clear.cgColor
        }
    func configure(with application: application) {
        applicationStatusLabel.text = application.status.rawValue
        dateStartedLabel.text = application.dateOfApplication
        dateEndLabel.text = application.dateOfApplication
        applicationNameLabel.text = application.jobSeeker.firstName
        
    }
    
    
    
}
