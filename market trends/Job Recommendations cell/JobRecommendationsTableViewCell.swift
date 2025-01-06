//
//  JobRecommendationsTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 26/12/2024.
//

import UIKit

class JobRecommendationsTableViewCell: UITableViewCell {
    static var identifer = "JobRecommendationsTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifer, bundle: nil)
    }
    var applyButtonTapped: (() -> Void)? // call back function
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with job: job) {
        titleLabel.text = job.jobTitle
        descriptionLabel.text = job.jobDescription
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        applyButtonTapped?()
    }
    
    
    
}
