//
//  EmployerInsightsTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 26/12/2024.
//

import UIKit

class EmployerInsightsTableViewCell: UITableViewCell {
    static var identifier = "EmployerInsightsTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "EmployerInsightsTableViewCell", bundle: nil)
    }
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    var appliedToJob: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with model: job) {
        jobTitleLabel.text = model.jobTitle
        jobDescriptionLabel.text = model.jobDescription
        
    }
    
}
