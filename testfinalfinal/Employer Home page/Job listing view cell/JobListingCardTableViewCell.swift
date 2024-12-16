//
//  JobListingCardTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class JobListingCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var CompanyLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var filter1: UIButton!
    
    @IBOutlet weak var filter2: UIButton!
    
    @IBOutlet weak var filter3: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    
    static var identifier = "JobListingCardTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "JobListingCardTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with job: job) {
        self.titleLabel.text = job.jobName
        self.CompanyLabel.text = job.companyName
        self.locationLabel.text = job.companyLocation
        self.timeLabel.text = "\(job.time) minutes ago"
        self.priceLabel.text = "\(job.salary)/\(job.type)"
        self.profileImage.image = UIImage(named: job.profilePicture)
        filter1.titleLabel?.text = job.filters[0]
        filter2.titleLabel?.text = job.filters[1]
        filter3.titleLabel?.text = job.filters[2]
    }
    
}
